import 'dart:math';
import 'package:flutter/material.dart';
import '../models/attribute.dart';
import '../models/character.dart';
import '../models/game_genre.dart';
import '../models/profession.dart';
import '../models/race.dart';
import '../models/recommended_build.dart';
import '../models/skill.dart';
import '../models/weapon.dart';
import '../models/armor.dart';
import '../services/character_storage.dart';
import '../services/game_data.dart';

class CharacterCreationWizard extends StatefulWidget {
  const CharacterCreationWizard({super.key});

  @override
  _CharacterCreationWizardState createState() =>
      _CharacterCreationWizardState();
}

class _CharacterCreationWizardState extends State<CharacterCreationWizard> {
  int _currentStep = 0;

  // Data
  String name = '';
  String concept = '';
  GameGenre? selectedGenre;
  Race? selectedRace;
  Profession? selectedProfession;

  Map<String, Attribute> attributes = {
    'STR': Attribute(name: 'Strength', value: 5),
    'CON': Attribute(name: 'Constitution', value: 5),
    'DEX': Attribute(name: 'Dexterity', value: 5),
    'INT': Attribute(name: 'Intellect', value: 5),
    'WIL': Attribute(name: 'Willpower', value: 5),
    'PER': Attribute(name: 'Perception', value: 5),
  };
  int attributePoints = 45;

  List<Skill> skills = [];

  @override
  void initState() {
    super.initState();
    _generateSkillList(); // Generate initial base skill list
  }

  void _generateSkillList() {
    // Base skills available in all genres
    List<Skill> baseSkills = [
      Skill(name: "Academics", governingAttribute: "INT"),
      Skill(name: "Athletics", governingAttribute: "DEX"),
      Skill(name: "Channeling", governingAttribute: "WIL"),
      Skill(name: "Deception", governingAttribute: "WIL"),
      Skill(name: "Intimidation", governingAttribute: "WIL"),
      Skill(name: "Investigation", governingAttribute: "INT"),
      Skill(name: "Larceny", governingAttribute: "DEX"),
      Skill(name: "Mechanics", governingAttribute: "INT"),
      Skill(name: "Medicine", governingAttribute: "INT"),
      Skill(name: "Melee Combat", governingAttribute: "STR"),
      Skill(name: "Notice", governingAttribute: "PER"),
      Skill(name: "Performance", governingAttribute: "WIL"),
      Skill(name: "Persuasion", governingAttribute: "WIL"),
      Skill(name: "Pilot", governingAttribute: "DEX"),
      Skill(name: "Ranged Combat", governingAttribute: "DEX"),
      Skill(name: "Stealth", governingAttribute: "DEX"),
      Skill(name: "Survival", governingAttribute: "PER"),
    ];

    // Genre-specific skills
    List<Skill> genreSkills = [];
    if (selectedGenre != null) {
      switch (selectedGenre!) {
        case GameGenre.fantasy:
          genreSkills.addAll([
            Skill(name: "Crafting", governingAttribute: "INT"),
            Skill(name: "Lore", governingAttribute: "INT"),
            Skill(name: "Ride", governingAttribute: "DEX"),
          ]);
          break;
        case GameGenre.sciFi:
          genreSkills.addAll([
            Skill(name: "Astrogation", governingAttribute: "INT"),
            Skill(name: "Computers", governingAttribute: "INT"),
            Skill(name: "Xenology", governingAttribute: "INT"),
          ]);
          break;
        case GameGenre.modern:
          genreSkills.addAll([
            Skill(name: "Computers", governingAttribute: "INT"),
            Skill(name: "Drive", governingAttribute: "DEX"),
            Skill(name: "Streetwise", governingAttribute: "PER"),
          ]);
          break;
      }
    }
    // Combine and sort the list for display
    skills = [...baseSkills, ...genreSkills];
    skills.sort((a, b) => a.name.compareTo(b.name));
  }


  int get skillPointsTotal => 150 + (selectedRace?.bonusSkillPoints ?? 0);
  int get skillPointsSpent {
    int spent = 0;
    for (var skill in skills) {
      bool isProf = selectedProfession?.professionalSkills.contains(skill.name) ?? false;
      int basePoints = isProf ? 10 : 0;
      basePoints += selectedRace?.skillBonuses[skill.name] ?? 0;

      if (skill.points > basePoints) {
        spent += skill.points - basePoints;
      }
    }
    return spent;
  }
  int get skillPointsRemaining => skillPointsTotal - skillPointsSpent;

  void _resetSelections() {
    selectedRace = null;
    selectedProfession = null;
    _resetAttributes();
    _resetSkills();
  }

  void _resetAttributes() {
    attributes = {
      'STR': Attribute(name: 'Strength', value: 5),
      'CON': Attribute(name: 'Constitution', value: 5),
      'DEX': Attribute(name: 'Dexterity', value: 5),
      'INT': Attribute(name: 'Intellect', value: 5),
      'WIL': Attribute(name: 'Willpower', value: 5),
      'PER': Attribute(name: 'Perception', value: 5),
    };
    attributePoints = 45;
  }

  void _applyRaceBonuses() {
    _resetAttributes();
    if (selectedRace != null) {
      selectedRace!.attributeModifiers.forEach((key, value) {
        attributes[key]!.value += value;
      });
    }
    _resetSkills();
  }

  void _resetSkills() {
    for (var skill in skills) {
      skill.points = 0;
    }
    _applyProfessionBonuses();
  }

  void _applyProfessionBonuses() {
    if (selectedRace != null) {
      selectedRace!.skillBonuses.forEach((skillName, bonus) {
        final skill = skills.firstWhere((s) => s.name == skillName, orElse: () => Skill(name: "Not Found", governingAttribute: "STR"));
        if(skill.name != "Not Found") {
          skill.points += bonus;
        }
      });
    }
    if (selectedProfession != null) {
      for (var profSkillName in selectedProfession!.professionalSkills) {
        final skill = skills.firstWhere((s) => s.name == profSkillName, orElse: () => Skill(name: "Not Found", governingAttribute: "STR"));
        if(skill.name != "Not Found") {
          skill.points = max(skill.points, 10);
        }
      }
    }
  }

  // NEW METHOD: Applies the recommended build.
  void _applyRecommendedBuild() {
    if (selectedProfession == null || selectedRace == null) return;

    final build = GameData.recommendedBuilds.firstWhere(
            (b) => b.professionName == selectedProfession!.name,
        orElse: () => RecommendedBuild(professionName: '', attributes: {}, skillPointsToAdd: {}));

    if (build.professionName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No recommended build found for ${selectedProfession!.name}.')),
      );
      return;
    }

    setState(() {
      // 1. Set attributes from the build
      build.attributes.forEach((key, value) {
        attributes[key]!.value = value;
      });
      attributePoints = 0; // The build uses all 45 points.

      // 2. Apply racial attribute modifiers ON TOP of the build
      selectedRace!.attributeModifiers.forEach((key, value) {
        attributes[key]!.value += value;
      });
      // Handle Human +2 bonus by letting the user add them
      if (selectedRace!.name == 'Human') {
        attributePoints += 2; // Give the 2 points for the user to spend.
      }


      // 3. Reset and apply skill bonuses
      _resetSkills();

      // 4. Apply skill points from the build
      build.skillPointsToAdd.forEach((skillName, points) {
        final skill = skills.firstWhere((s) => s.name == skillName, orElse: () => Skill(name: 'Not Found', governingAttribute: 'STR'));
        if (skill.name != 'Not Found') {
          skill.points += points;
        }
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recommended build for ${selectedProfession!.name} applied! You can now customize it.'), duration: Duration(seconds: 3)),
    );
  }


  @override
  Widget build(BuildContext context) {
    // NEW: Defined the steps list here to make reordering easier
    final steps = [
      _buildGenreStep(),
      _buildRaceStep(),
      _buildProfessionStep(),
      _buildConceptStep(),
      _buildAttributesStep(),
      _buildSkillsStep(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Create Character')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          bool canContinue = false;
          switch(_currentStep) {
            case 0: canContinue = selectedGenre != null; break;
            case 1: canContinue = selectedRace != null; break;
            case 2: canContinue = selectedProfession != null; break;
            case 3: canContinue = true; break;
            case 4: canContinue = attributePoints >= 0; break;
            case 5: canContinue = skillPointsRemaining >= 0; break;
          }
          // MODIFICATION: Use steps.length to be more flexible
          if (_currentStep < steps.length - 1 && canContinue) {
            setState(() => _currentStep += 1);
          } else if (canContinue) {
            _finishCreation();
          } else {
            String message = 'Please make a selection to continue.';
            if (_currentStep == 4 && attributePoints < 0) {
              message = 'You have spent too many attribute points.';
            } else if (_currentStep == 5 && skillPointsRemaining < 0) {
              message = 'You have spent too many skill points.';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        onStepTapped: (step) => setState(() => _currentStep = step),
        steps: steps, // Use the defined list
      ),
    );
  }

  Step _buildGenreStep() {
    return Step(
        title: const Text('Genre'),
        isActive: _currentStep >= 0,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose your campaign setting.", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ...GameGenre.values.map((genre) {
              return RadioListTile<GameGenre>(
                title: Text(genre.toString().split('.').last),
                value: genre,
                groupValue: selectedGenre,
                onChanged: (GameGenre? value) {
                  if (selectedGenre == value) return; // No change
                  setState(() {
                    selectedGenre = value;
                    _generateSkillList(); // Generate new list before resetting
                    _resetSelections();   // Reset logic will now use the new list
                  });
                },
              );
            }).toList(),
          ],
        )
    );
  }

  Step _buildRaceStep() {
    List<Race> availableRaces = selectedGenre != null ? GameData.getRacesForGenre(selectedGenre!) : [];
    return Step(
      title: const Text('Race'),
      isActive: _currentStep >= 1,
      state: selectedGenre == null ? StepState.disabled : StepState.indexed,
      content: Column(
        children: [
          DropdownButtonFormField<Race>(
            value: selectedRace,
            hint: const Text('Choose a Race'),
            isExpanded: true,
            items: availableRaces.map((Race race) {
              return DropdownMenuItem<Race>(
                value: race,
                child: Text(race.name),
              );
            }).toList(),
            onChanged: (Race? value) {
              setState(() {
                selectedRace = value;
                _applyRaceBonuses();
              });
            },
          ),
          const SizedBox(height: 20),
          if (selectedRace != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedRace!.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(selectedRace!.description),
                    if (selectedRace!.abilities.isNotEmpty) ...[
                      const Divider(height: 20),
                      Text("Abilities:", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ...selectedRace!.abilities.map((ability) => Text("• $ability")),
                    ]
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // NEW ORDER: Profession step moved up
  Step _buildProfessionStep() {
    List<Profession> availableProfessions = selectedGenre != null ? GameData.getProfessionsForGenre(selectedGenre!) : [];
    return Step(
      title: const Text('Profession'),
      isActive: _currentStep >= 2,
      state: selectedRace == null ? StepState.disabled : StepState.indexed,
      content: Column(
        children: [
          DropdownButtonFormField<Profession>(
            value: selectedProfession,
            hint: const Text('Choose a Profession'),
            isExpanded: true,
            items: availableProfessions.map((Profession prof) {
              return DropdownMenuItem<Profession>(
                value: prof,
                child: Text(prof.name),
              );
            }).toList(),
            onChanged: (Profession? value) {
              setState(() {
                selectedProfession = value;
                _resetSkills();
              });
            },
          ),
          const SizedBox(height: 20),
          if (selectedProfession != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(selectedProfession!.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(selectedProfession!.description),
                    const SizedBox(height: 16),
                    Text("Professional Skills (+10 Bonus):", style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: selectedProfession!.professionalSkills.map((skillName) => Chip(label: Text(skillName))).toList(),
                    ),
                    const Divider(height: 20),
                    // NEW: Recommended Build Button
                    ElevatedButton.icon(
                      icon: const Icon(Icons.auto_fix_high),
                      label: const Text("Apply Recommended Build"),
                      onPressed: _applyRecommendedBuild,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }


  Step _buildConceptStep() {
    return Step(
      title: const Text('Concept'),
      isActive: _currentStep >= 3,
      state: selectedProfession == null ? StepState.disabled : StepState.indexed,
      content: Column(children: [
        TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            onChanged: (val) => setState(() => name = val)),
        TextFormField(
            decoration: const InputDecoration(labelText: 'Concept / Background'),
            onChanged: (val) => setState(() => concept = val)),
      ]),
    );
  }

  Step _buildAttributesStep() {
    return Step(
      title: const Text('Attributes'),
      isActive: _currentStep >= 4,
      state: selectedProfession == null ? StepState.disabled : StepState.indexed,
      content: Column(
        children: [
          Text("Points Remaining: $attributePoints", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ...attributes.entries.map((entry) {
            // Recalculate base value considering racial modifiers for disabled state
            int baseValueWithoutPoints = 5 + (selectedRace?.attributeModifiers[entry.key] ?? 0);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.value.name, style: const TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: entry.value.value > baseValueWithoutPoints ? () {
                        setState(() {
                          entry.value.value--;
                          attributePoints++;
                        });
                      } : null,
                    ),
                    Text(entry.value.value.toString(), style: const TextStyle(fontSize: 20)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: attributePoints > 0 && entry.value.value < 20 ? () {
                        setState(() {
                          entry.value.value++;
                          attributePoints--;
                        });
                      } : null,
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }


  Step _buildSkillsStep() {
    return Step(
      title: const Text('Skills'),
      isActive: _currentStep >= 5,
      state: selectedProfession == null ? StepState.disabled : StepState.indexed,
      content: Column(
        children: [
          Text("Skill Points Remaining: $skillPointsRemaining",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: skillPointsRemaining < 0 ? Colors.redAccent : null
              )),
          Text("Total Points: $skillPointsTotal", style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                final baseValue = attributes[skill.governingAttribute.split('/').first]!.value;
                final isProfessional = selectedProfession?.professionalSkills.contains(skill.name) ?? false;
                final racialBonus = selectedRace?.skillBonuses[skill.name] ?? 0;
                final baseSkillPoints = (isProfessional ? 10 : 0) + racialBonus;

                return Row(
                  children: [
                    Expanded(child: Text("${skill.name} (${skill.governingAttribute})", style: TextStyle(fontSize: 16, color: isProfessional ? Colors.cyanAccent : (racialBonus > 0 ? Colors.greenAccent : null), fontWeight: isProfessional ? FontWeight.bold : FontWeight.normal))),
                    Text((baseValue + skill.points).toString(), style: const TextStyle(fontSize: 20)),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: skill.points > baseSkillPoints ? () => setState(() => skill.points--) : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: (baseValue + skill.points) < 75 ? () => setState(() => skill.points++) : null,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _finishCreation() async {
    final newChar = Character(
      name: name.isNotEmpty ? name : "Unnamed",
      raceName: selectedRace?.name ?? "Human",
      professionName: selectedProfession?.name ?? "Adventurer",
      concept: concept,
      genre: selectedGenre ?? GameGenre.modern,
      attributes: attributes,
      skills: skills,
    );

    if(selectedProfession != null) {
      for (var gearName in selectedProfession!.startingGear) {
        final weapon = GameData.masterWeaponList.firstWhere((w) => w.name == gearName, orElse: () => Weapon(name: ''));
        if (weapon.name.isNotEmpty) {
          newChar.weapons.add(Weapon(name: weapon.name, damage: weapon.damage, notes: weapon.notes));
          continue;
        }
        final armor = GameData.masterArmorList.firstWhere((a) => a.name == gearName, orElse: () => Armor(name: ''));
        if (armor.name.isNotEmpty) {
          newChar.armor.add(Armor(name: armor.name, armorValue: armor.armorValue, notes: armor.notes, isEquipped: true));
          continue;
        }

        if (newChar.inventory.isNotEmpty) {
          newChar.inventory += '\n';
        }
        newChar.inventory += gearName;
      }
    }


    await CharacterStorage.saveCharacter(newChar);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}