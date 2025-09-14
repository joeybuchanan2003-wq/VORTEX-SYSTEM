import 'dart:math';
import 'package:flutter/material.dart';
import '../models/armor.dart';
import '../models/attribute.dart';
import '../models/character.dart';
import '../models/spell.dart';
import '../models/weapon.dart';
import '../services/character_storage.dart';
import '../services/game_data.dart';
import '../widgets/custom_text_form_field.dart';

class CharacterSheetScreen extends StatefulWidget {
  final Character character;
  const CharacterSheetScreen({super.key, required this.character});

  @override
  _CharacterSheetScreenState createState() => _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends State<CharacterSheetScreen> {
  late Character character;

  @override
  void initState() {
    super.initState();
    character = widget.character;
    character.currentHp ??= character.maxHp;
    character.currentRp ??= character.maxRp;
    character.currentLuck ??= character.maxLuck;
  }

  void _updateCharacter() {
    setState(() {
      character.currentHp = min(character.currentHp!, character.maxHp);
      character.currentRp = min(character.currentRp!, character.maxRp);
      character.currentLuck = min(character.currentLuck!, character.maxLuck);
    });
  }

  void _saveCharacter() async {
    await CharacterStorage.saveCharacter(character);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Character Saved!'), duration: Duration(seconds: 2)),
    );
  }

  void _deleteCharacter() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Character'),
        content: Text('Are you sure you want to delete ${character.name}? This cannot be undone.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.of(ctx).pop()),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
            onPressed: () async {
              await CharacterStorage.deleteCharacter(character.id);
              if (mounted) {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(character.name.isEmpty ? 'New Character' : character.name),
          actions: [
            IconButton(icon: const Icon(Icons.save), onPressed: _saveCharacter, tooltip: 'Save'),
            IconButton(icon: const Icon(Icons.delete_forever), onPressed: _deleteCharacter, tooltip: 'Delete')
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.person), text: "Stats"),
              Tab(icon: Icon(Icons.star), text: "Skills"),
              Tab(icon: Icon(Icons.auto_awesome), text: "Magic"),
              Tab(icon: Icon(Icons.shield), text: "Combat"),
              Tab(icon: Icon(Icons.notes), text: "Notes"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStatsTab(),
            _buildSkillsTab(),
            _buildMagicTab(),
            _buildCombatTab(),
            _buildNotesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCharacterInfoCard(),
          const SizedBox(height: 16),
          _buildDerivedStatsCard(),
          const SizedBox(height: 16),
          _buildAttributesCard(),
          const SizedBox(height: 16),
          _buildRacialAbilitiesCard(),
        ],
      ),
    );
  }

  Widget _buildSkillsTab() {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: character.skills.length,
        itemBuilder: (context, index) {
          final skill = character.skills[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ListTile(
              title: Text(skill.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Base: ${skill.governingAttribute} (${character.getAttr(skill.governingAttribute.split('/').first)}) + ${skill.points} pts"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    skill.getRating(character).toString(),
                    style: const TextStyle(fontSize: 24, color: Colors.cyanAccent),
                  ),
                  const SizedBox(width: 16),
                  Checkbox(
                    value: skill.improvementCheck,
                    onChanged: (bool? value) {
                      setState(() {
                        skill.improvementCheck = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              onTap: () => _editSkillDialog(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMagicTab() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildStatTracker("Resolve Points (RP)", character.currentRp!, character.maxRp, (val) => setState(() => character.currentRp = val)),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Known Spells", style: Theme.of(context).textTheme.titleLarge),
                    const Divider(height: 20),
                    character.spells.isEmpty
                        ? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('No spells known.')))
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: character.spells.length,
                      itemBuilder: (context, index) {
                        final spell = character.spells[index];
                        return ListTile(
                          title: Text(spell.name),
                          subtitle: Text(spell.description),
                          trailing: Text("Cost: ${spell.spCost} RP", style: const TextStyle(fontSize: 16)),
                          onTap: () => _editSpellDialog(index),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSpellDialog,
        label: const Text("Learn Spell"),
        icon: const Icon(Icons.add),
        heroTag: 'addSpell',
      ),
    );
  }


  Widget _buildCombatTab() {
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Armor", style: Theme.of(context).textTheme.titleLarge),
                          Text("Total AV: ${character.armorValue}", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.cyanAccent)),
                        ],
                      ),
                      const Divider(height: 20),
                      character.armor.isEmpty
                          ? const Center(child: Padding(padding: EdgeInsets.all(8.0), child:Text('No armor added.')))
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: character.armor.length,
                        itemBuilder: (context, index) {
                          final piece = character.armor[index];
                          return ListTile(
                            title: Text(piece.name),
                            subtitle: piece.notes.isNotEmpty ? Text(piece.notes) : null,
                            leading: Checkbox(
                              value: piece.isEquipped,
                              onChanged: (val) {
                                setState(() {
                                  piece.isEquipped = val ?? false;
                                });
                              },
                            ),
                            trailing: Text("AV: ${piece.armorValue}", style: const TextStyle(fontSize: 16)),
                            onTap: () => _editArmorDialog(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Weapons", style: Theme.of(context).textTheme.titleLarge),
                      const Divider(height: 20),
                      character.weapons.isEmpty
                          ? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text('No weapons added.')))
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: character.weapons.length,
                        itemBuilder: (context, index) {
                          final weapon = character.weapons[index];
                          return ListTile(
                            title: Text(weapon.name),
                            subtitle: weapon.notes.isNotEmpty ? Text(weapon.notes) : null,
                            trailing: Text("Dmg: ${weapon.damage}", style: const TextStyle(fontSize: 16)),
                            onTap: () => _editWeaponDialog(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("General Inventory", style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        label: 'Other items...',
                        initialValue: character.inventory,
                        maxLines: 10,
                        onChanged: (value) {
                          character.inventory = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              onPressed: _addArmorDialog,
              label: const Text("Add Armor"),
              icon: const Icon(Icons.shield),
              heroTag: 'addArmor',
            ),
            const SizedBox(height: 10),
            FloatingActionButton.extended(
              onPressed: _addWeaponDialog,
              label: const Text("Add Weapon"),
              icon: const Icon(Icons.gavel),
              heroTag: 'addWeapon',
            ),
          ],
        )
    );
  }

  Widget _buildNotesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Major Wounds", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    label: 'Describe Wounds...',
                    initialValue: character.majorWounds,
                    maxLines: 5,
                    onChanged: (value) {
                      character.majorWounds = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Character Notes", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    label: 'Background, contacts, etc...',
                    initialValue: character.notes,
                    maxLines: 15,
                    onChanged: (value) {
                      character.notes = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENT WIDGETS ---

  Widget _buildCharacterInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Character Name',
              initialValue: character.name,
              onChanged: (value) {
                setState(() {
                  character.name = value;
                });
              },
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              label: 'Race',
              initialValue: character.raceName,
              onChanged: (value) => character.raceName = value,
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              label: 'Profession',
              initialValue: character.professionName,
              onChanged: (value) => character.professionName = value,
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              label: 'Concept',
              initialValue: character.concept,
              onChanged: (value) => character.concept = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDerivedStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatTracker("Hit Points (HP)", character.currentHp!, character.maxHp, (val) => setState(() => character.currentHp = val)),
            _buildStatTracker("Resolve Points (RP)", character.currentRp!, character.maxRp, (val) => setState(() => character.currentRp = val)),
            _buildStatTracker("Luck Points", character.currentLuck!, character.maxLuck, (val) => setState(() => character.currentLuck = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTracker(String label, int currentValue, int maxValue, Function(int) updateValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 16)),
              Text('$currentValue / $maxValue', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: maxValue > 0 ? currentValue / maxValue : 0,
                  minHeight: 12,
                  backgroundColor: Colors.grey.shade700,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () => updateValue(max(0, currentValue - 1)),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () => updateValue(min(maxValue, currentValue + 1)),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttributesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: character.attributes.entries.map((entry) {
            return _buildAttributeInput(entry.key, entry.value);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRacialAbilitiesCard() {
    final race = GameData.races.firstWhere((r) => r.name == character.raceName, orElse: () => GameData.races.first);
    if(race.abilities.isEmpty) return Container();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Racial Abilities", style: Theme.of(context).textTheme.titleLarge),
            const Divider(height: 20),
            ...race.abilities.map((ability) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("• $ability"),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeInput(String key, Attribute attribute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attribute.name, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: attribute.value.toString(),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          onChanged: (value) {
            attribute.value = int.tryParse(value) ?? 10;
            _updateCharacter();
          },
        ),
      ],
    );
  }

  Future<void> _editSkillDialog(int skillIndex) async {
    final skill = character.skills[skillIndex];
    final pointsController = TextEditingController(text: skill.points.toString());

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${skill.name}'),
          content: TextFormField(
            controller: pointsController,
            decoration: const InputDecoration(labelText: 'Skill Points'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  skill.points = int.tryParse(pointsController.text) ?? skill.points;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // --- DIALOGS FOR MAGIC TAB ---

  Future<void> _addSpellDialog() async {
    final availableSpells = GameData.getSpellsForGenre(character.genre);

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Learn Spell"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: availableSpells.length,
                    itemBuilder: (context, index) {
                      final spell = availableSpells[index];
                      return ListTile(
                          title: Text(spell.name),
                          subtitle: Text("Cost: ${spell.spCost} RP\n${spell.description}"),
                          onTap: () {
                            setState(() {
                              character.spells.add(Spell(name: spell.name, spCost: spell.spCost, description: spell.description));
                            });
                            Navigator.of(context).pop();
                          }
                      );
                    }
                ),
              ),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))]
          );
        }
    );
  }

  Future<void> _editSpellDialog(int spellIndex) async {
    final spell = character.spells[spellIndex];
    final nameController = TextEditingController(text: spell.name);
    final costController = TextEditingController(text: spell.spCost.toString());
    final descController = TextEditingController(text: spell.description);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${spell.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Spell Name')),
                TextFormField(controller: costController, decoration: const InputDecoration(labelText: 'SP Cost (RP)'), keyboardType: TextInputType.number),
                TextFormField(controller: descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 4),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              onPressed: () {
                setState(() => character.spells.removeAt(spellIndex));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  spell.name = nameController.text;
                  spell.spCost = int.tryParse(costController.text) ?? 0;
                  spell.description = descController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }


  // --- DIALOGS FOR COMBAT TAB ---

  Future<void> _addWeaponDialog() async {
    final availableWeapons = GameData.getWeaponsForGenre(character.genre);

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add Weapon"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: availableWeapons.length,
                    itemBuilder: (context, index) {
                      final weapon = availableWeapons[index];
                      return ListTile(
                          title: Text(weapon.name),
                          subtitle: Text("Dmg: ${weapon.damage}"),
                          onTap: () {
                            setState(() {
                              character.weapons.add(Weapon(name: weapon.name, damage: weapon.damage, notes: weapon.notes));
                            });
                            Navigator.of(context).pop();
                          }
                      );
                    }
                ),
              ),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))]
          );
        }
    );
  }

  Future<void> _editWeaponDialog(int weaponIndex) async {
    final weapon = character.weapons[weaponIndex];
    final nameController = TextEditingController(text: weapon.name);
    final damageController = TextEditingController(text: weapon.damage);
    final notesController = TextEditingController(text: weapon.notes);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${weapon.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Weapon Name'),
              ),
              TextFormField(
                controller: damageController,
                decoration: const InputDecoration(labelText: 'Damage'),
              ),
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              onPressed: () {
                setState(() {
                  character.weapons.removeAt(weaponIndex);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  weapon.name = nameController.text;
                  weapon.damage = damageController.text;
                  weapon.notes = notesController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addArmorDialog() async {
    final availableArmor = GameData.getArmorForGenre(character.genre);
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add Armor"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: availableArmor.length,
                    itemBuilder: (context, index) {
                      final piece = availableArmor[index];
                      return ListTile(
                          title: Text(piece.name),
                          subtitle: Text("AV: ${piece.armorValue}"),
                          onTap: () {
                            setState(() {
                              character.armor.add(Armor(name: piece.name, armorValue: piece.armorValue, notes: piece.notes, isEquipped: true));
                            });
                            Navigator.of(context).pop();
                          }
                      );
                    }
                ),
              ),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))]
          );
        }
    );
  }

  Future<void> _editArmorDialog(int armorIndex) async {
    final piece = character.armor[armorIndex];
    final nameController = TextEditingController(text: piece.name);
    final avController = TextEditingController(text: piece.armorValue.toString());
    final notesController = TextEditingController(text: piece.notes);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${piece.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Armor Name'),
              ),
              TextFormField(
                controller: avController,
                decoration: const InputDecoration(labelText: 'Armor Value (AV)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              onPressed: () {
                setState(() {
                  character.armor.removeAt(armorIndex);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  piece.name = nameController.text;
                  piece.armorValue = int.tryParse(avController.text) ?? 0;
                  piece.notes = notesController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}