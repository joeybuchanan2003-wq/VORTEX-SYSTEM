import '../models/race.dart';
import '../models/profession.dart';
import '../models/game_genre.dart';
import '../models/recommended_build.dart';
import '../models/spell.dart';
import '../models/weapon.dart';
import '../models/armor.dart';

// --- GAME DATA SERVICE ---
class GameData {
  static final List<Race> races = [
    Race(name: "Human", description: "Adaptable, ambitious, and numerous, humans are the baseline standard found across most worlds and genres.", attributeModifiers: {}, bonusSkillPoints: 20),
    Race(name: "Elf", description: "A graceful, long-lived people with a deep connection to nature and magic.", attributeModifiers: {'DEX': 2, 'CON': -1}, abilities: ["Keen Senses: +10 to Notice tests (sight/hearing).", "Fey Ancestry: +10 to WIL tests vs. mind-altering effects."], skillBonuses: {'Notice': 10}),
    Race(name: "Dwarf", description: "Stoic, resilient, and masterfully skilled artisans who dwell in mountain strongholds.", attributeModifiers: {'CON': 2, 'DEX': -1}, abilities: ["Toughness: +2 bonus HP.", "Darkvision: See in darkness up to 20m.", "Stonecunning: +10 to Academics/Notice for stonework."]),
    Race(name: "Orc", description: "A proud and powerful people, often misunderstood and stereotyped for their warlike history.", attributeModifiers: {'STR': 2, 'INT': -1}, abilities: ["Relentless Endurance: Once per day, drop to 1 HP instead of 0 on a CON test.", "Savage Attacks: Add full STR to damage on Hard/Crit melee success."]),
    Race(name: "Cygnian", description: "Tall, slender beings with pale blue skin and large, dark eyes, who value logic and telepathic communion.", attributeModifiers: {'INT': 2, 'STR': -1}, abilities: ["Innate Telepathy: Communicate emotions/concepts within 10m.", "Fragile Frame: Suffer -1 HP damage from kinetic sources."]),
    Race(name: "Saurian", description: "Reptilian humanoids with scaled hides and impressive strength from a harsh desert world.", attributeModifiers: {'STR': 2, 'WIL': -1}, abilities: ["Natural Armor: Provides a natural AV of 1.", "Desert Survivor: +10 to Survival tests in deserts/jungles."], skillBonuses: {'Survival': 10}),
    Race(name: "Gremlin", description: "A diminutive, hyper-intelligent species with an innate ability to understand technology.", attributeModifiers: {'INT': 2, 'CON': -1}, abilities: ["Tech-Whisperer: +10 to Mechanics tests.", "Small Stature: -5 penalty on ranged attacks against them."], skillBonuses: {'Mechanics': 10}),
  ];

  static final List<Profession> professions = [
    // Modern
    Profession(name: "Detective", description: "A gritty investigator who walks the mean streets.", professionalSkills: ["Investigation", "Notice", "Persuasion", "Streetwise", "Ranged Combat"], genre: GameGenre.modern, startingGear: ["Heavy Pistol", "Ballistic Vest", "Binoculars"]),
    Profession(name: "Medic", description: "A trained professional who can patch up the wounded.", professionalSkills: ["Medicine", "Academics", "Notice", "Persuasion", "Drive"], genre: GameGenre.modern, startingGear: ["Light Pistol", "Medkit (Advanced)"]),
    Profession(name: "Soldier", description: "A disciplined combatant trained in tactics and firearms.", professionalSkills: ["Ranged Combat", "Melee Combat", "Athletics", "Survival", "Intimidation"], genre: GameGenre.modern, startingGear: ["Assault Rifle", "Knife", "Ballistic Vest", "Frag Grenade"]),
    Profession(name: "Mechanic", description: "A hands-on expert in engines, vehicles, and all things mechanical.", professionalSkills: ["Mechanics", "Drive", "Investigation", "Notice", "Ranged Combat"], genre: GameGenre.modern, startingGear: ["Light Pistol", "Tool Kit (Mechanical)"]),
    Profession(name: "IT Technician", description: "A specialist in computer networks, software, and digital security.", professionalSkills: ["Computers", "Mechanics", "Academics", "Investigation", "Larceny"], genre: GameGenre.modern, startingGear: ["Light Pistol", "Hacking Device", "Multitool"]),
    Profession(name: "Journalist", description: "An inquisitive and tenacious investigator of the truth.", professionalSkills: ["Investigation", "Persuasion", "Academics", "Notice", "Streetwise"], genre: GameGenre.modern, startingGear: ["Light Pistol", "Audio Recorder", "Press Pass"]),
    Profession(name: "Getaway Driver", description: "An expert of the road with nerves of steel.", professionalSkills: ["Drive", "Mechanics", "Notice", "Larceny", "Ranged Combat"], genre: GameGenre.modern, startingGear: ["Light Pistol", "Tool Kit (Mechanical)"]),
    Profession(name: "Occultist", description: "A seeker of forbidden knowledge who performs strange rituals to influence reality from the shadows.", professionalSkills: ["Channeling", "Academics", "Investigation", "Persuasion", "Lore"], genre: GameGenre.modern, startingGear: ["Knife", "Ritual Components (Basic)", "Talisman", "Esoteric Texts"]),
    Profession(name: "Fixer", description: "A well-connected underworld broker who trades in information, goods, and favors.", professionalSkills: ["Streetwise", "Persuasion", "Deception", "Notice", "Larceny"], genre: GameGenre.modern, startingGear: ["Light Pistol", "Burner Phone (3)"]),
    Profession(name: "Paramedic", description: "A first-responder who thrives under pressure to save lives on the streets.", professionalSkills: ["Medicine", "Drive", "Notice", "Athletics", "Persuasion"], genre: GameGenre.modern, startingGear: ["Medkit (Advanced)", "Stun Baton"]),
    // Sci-Fi
    Profession(name: "Starship Pilot", description: "A hotshot ace more at home in the cockpit.", professionalSkills: ["Pilot", "Mechanics", "Ranged Combat", "Notice", "Astrogation"], genre: GameGenre.sciFi, startingGear: ["Laser Pistol", "Tool Kit (Mechanical)", "Flight Suit"]),
    Profession(name: "Cyber-Runner", description: "A street-savvy operative who blends flesh with technology.", professionalSkills: ["Computers", "Stealth", "Mechanics", "Investigation", "Deception"], genre: GameGenre.sciFi, startingGear: ["Submachine Gun", "Vibro-blade", "Synth-Leather", "Hacking Device"]),
    Profession(name: "Explorer", description: "A bold pioneer who charts unknown star systems.", professionalSkills: ["Survival", "Pilot", "Investigation", "Notice", "Medicine"], genre: GameGenre.sciFi, startingGear: ["Laser Rifle", "Knife", "Combat Armor", "Medkit (Basic)", "Rations (3 days)"]),
    Profession(name: "Diplomat", description: "An eloquent and sharp-witted envoy.", professionalSkills: ["Persuasion", "Deception", "Academics", "Notice", "Performance"], genre: GameGenre.sciFi, startingGear: ["Personal Datapad", "Formal Attire"]),
    Profession(name: "Bounty Hunter", description: "A relentless tracker who hunts targets across the galaxy.", professionalSkills: ["Investigation", "Ranged Combat", "Intimidation", "Survival", "Larceny"], genre: GameGenre.sciFi, startingGear: ["Heavy Pistol", "Combat Armor", "Stun Baton"]),
    Profession(name: "Xeno-Scientist", description: "A brilliant researcher who studies alien life.", professionalSkills: ["Investigation", "Academics", "Medicine", "Xenology", "Notice"], genre: GameGenre.sciFi, startingGear: ["Laser Pistol", "Medkit (Advanced)", "Analysis Kit"]),
    Profession(name: "Navigator", description: "An expert in charting faster-than-light courses through the treacherous void.", professionalSkills: ["Astrogation", "Computers", "Pilot", "Notice", "Academics"], genre: GameGenre.sciFi, startingGear: ["Laser Pistol", "Personal Datapad", "Flight Suit"]),
    Profession(name: "Hacker", description: "A digital ghost who infiltrates secure networks for profit or principle.", professionalSkills: ["Computers", "Investigation", "Stealth", "Mechanics", "Notice"], genre: GameGenre.sciFi, startingGear: ["Laser Pistol", "Hacking Device"]),
    Profession(name: "Xeno-Ambassador", description: "A specialist in first contact scenarios, trained to understand and negotiate with alien species.", professionalSkills: ["Xenology", "Persuasion", "Academics", "Notice", "Deception"], genre: GameGenre.sciFi, startingGear: ["Formal Attire", "Personal Datapad", "Universal Translator (Prototype)"]),
    // Fantasy
    Profession(name: "Knight", description: "A noble warrior bound by an oath, clad in steel.", professionalSkills: ["Melee Combat", "Intimidation", "Athletics", "Ride", "Persuasion"], genre: GameGenre.fantasy, startingGear: ["Longsword", "Plate Armor", "Shield"]),
    Profession(name: "Rogue", description: "A cunning thief and infiltrator who thrives in the shadows.", professionalSkills: ["Larceny", "Stealth", "Investigation", "Athletics", "Melee Combat"], genre: GameGenre.fantasy, startingGear: ["Shortsword", "Dagger", "Leather", "Lockpick Set"]),
    Profession(name: "Wizard", description: "A dedicated scholar of the arcane arts.", professionalSkills: ["Channeling", "Academics", "Lore", "Investigation", "Notice"], genre: GameGenre.fantasy, startingGear: ["Quarterstaff", "Dagger", "Spellbook"]),
    Profession(name: "Ranger", description: "A master of the wilderness who tracks beasts and monsters.", professionalSkills: ["Survival", "Ranged Combat", "Investigation", "Notice", "Melee Combat"], genre: GameGenre.fantasy, startingGear: ["Longbow", "Shortsword", "Leather", "Rope (15m)"]),
    Profession(name: "Barbarian", description: "A fearsome warrior from the untamed wilds.", professionalSkills: ["Melee Combat", "Survival", "Intimidation", "Athletics", "Notice"], genre: GameGenre.fantasy, startingGear: ["Great Axe", "Leather"]),
    Profession(name: "Priest", description: "A devout servant of a higher power.", professionalSkills: ["Medicine", "Persuasion", "Academics", "Channeling", "Investigation"], genre: GameGenre.fantasy, startingGear: ["Club / Bat", "Shield", "Holy Symbol"]),
    Profession(name: "Squire", description: "A young warrior in training, learning the ways of war and chivalry.", professionalSkills: ["Melee Combat", "Ride", "Athletics", "Persuasion", "Crafting"], genre: GameGenre.fantasy, startingGear: ["Shortsword", "Leather", "Shield"]),
    Profession(name: "Alchemist", description: "A master of potions, poultices, and explosive concoctions.", professionalSkills: ["Crafting", "Academics", "Investigation", "Notice", "Deception"], genre: GameGenre.fantasy, startingGear: ["Dagger", "Alchemist's Kit"]),
    Profession(name: "Scholar", description: "A master of esoteric knowledge, forgotten histories, and ancient languages.", professionalSkills: ["Lore", "Academics", "Investigation", "Notice", "Persuasion"], genre: GameGenre.fantasy, startingGear: ["Dagger", "Esoteric Texts", "Writing Kit"]),
  ];

  // A list of recommended builds for quick-start characters.
  static final List<RecommendedBuild> recommendedBuilds = [
    // Modern
    RecommendedBuild(
        professionName: "Detective",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 12, 'INT': 15, 'WIL': 13, 'PER': 14},
        skillPointsToAdd: {
          'Investigation': 35, 'Notice': 25, 'Persuasion': 25, 'Streetwise': 15, 'Ranged Combat': 10,
          'Drive': 15, 'Intimidation': 15, 'Academics': 10,
        }),
    RecommendedBuild(
        professionName: "Soldier",
        attributes: {'STR': 13, 'CON': 14, 'DEX': 15, 'INT': 10, 'WIL': 11, 'PER': 12},
        skillPointsToAdd: {
          'Ranged Combat': 35, 'Melee Combat': 25, 'Athletics': 20, 'Survival': 10, 'Intimidation': 10,
          'Notice': 20, 'Drive': 15, 'Mechanics': 15,
        }),
    RecommendedBuild(
        professionName: "Medic",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 12, 'INT': 15, 'WIL': 13, 'PER': 14},
        skillPointsToAdd: {
          'Medicine': 40, 'Academics': 25, 'Notice': 20, 'Persuasion': 15, 'Drive': 10,
          'Investigation': 20, 'Computers': 10, 'Streetwise': 10,
        }),
    RecommendedBuild(
        professionName: "Mechanic",
        attributes: {'STR': 12, 'CON': 13, 'DEX': 14, 'INT': 15, 'WIL': 10, 'PER': 11},
        skillPointsToAdd: {
          'Mechanics': 40, 'Drive': 30, 'Investigation': 15, 'Notice': 15, 'Ranged Combat': 10,
          'Athletics': 15, 'Streetwise': 15, 'Larceny': 10,
        }),
    RecommendedBuild(
        professionName: "IT Technician",
        attributes: {'STR': 9, 'CON': 10, 'DEX': 14, 'INT': 17, 'WIL': 12, 'PER': 13},
        skillPointsToAdd: {
          'Computers': 40, 'Mechanics': 25, 'Academics': 15, 'Investigation': 20, 'Larceny': 10,
          'Stealth': 15, 'Notice': 15, 'Persuasion': 10,
        }),
    RecommendedBuild(
        professionName: "Journalist",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 12, 'INT': 15, 'WIL': 14, 'PER': 13},
        skillPointsToAdd: {
          'Investigation': 35, 'Persuasion': 30, 'Academics': 20, 'Notice': 15, 'Streetwise': 10,
          'Deception': 15, 'Stealth': 15, 'Computers': 10,
        }),
    RecommendedBuild(
        professionName: "Getaway Driver",
        attributes: {'STR': 11, 'CON': 12, 'DEX': 15, 'INT': 10, 'WIL': 12, 'PER': 15},
        skillPointsToAdd: {
          'Drive': 40, 'Mechanics': 25, 'Notice': 20, 'Larceny': 15, 'Ranged Combat': 10,
          'Stealth': 20, 'Streetwise': 10, 'Athletics': 10,
        }),
    RecommendedBuild(
        professionName: "Occultist",
        attributes: {'STR': 8, 'CON': 11, 'DEX': 10, 'INT': 16, 'WIL': 17, 'PER': 13},
        skillPointsToAdd: {
          'Channeling': 40, 'Academics': 25, 'Investigation': 25, 'Persuasion': 10, 'Lore': 10,
          'Deception': 15, 'Stealth': 15, 'Medicine': 10,
        }),
    RecommendedBuild(
        professionName: "Fixer",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 12, 'INT': 13, 'WIL': 15, 'PER': 14},
        skillPointsToAdd: {
          'Streetwise': 35, 'Persuasion': 30, 'Deception': 25, 'Notice': 10, 'Larceny': 10,
          'Investigation': 15, 'Drive': 15, 'Intimidation': 10,
        }),
    RecommendedBuild(
        professionName: "Paramedic",
        attributes: {'STR': 11, 'CON': 12, 'DEX': 14, 'INT': 14, 'WIL': 13, 'PER': 11},
        skillPointsToAdd: {
          'Medicine': 40, 'Drive': 30, 'Notice': 15, 'Athletics': 15, 'Persuasion': 10,
          'Streetwise': 15, 'Investigation': 15, 'Melee Combat': 10,
        }),
    // Sci-Fi
    RecommendedBuild(
        professionName: "Starship Pilot",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 15, 'INT': 13, 'WIL': 12, 'PER': 14},
        skillPointsToAdd: {
          'Pilot': 40, 'Mechanics': 25, 'Ranged Combat': 20, 'Notice': 15, 'Astrogation': 10,
          'Computers': 15, 'Persuasion': 15, 'Athletics': 10,
        }),
    RecommendedBuild(
        professionName: "Cyber-Runner",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 15, 'INT': 14, 'WIL': 12, 'PER': 13},
        skillPointsToAdd: {
          'Computers': 30, 'Stealth': 30, 'Mechanics': 20, 'Investigation': 15, 'Deception': 15,
          'Streetwise': 15, 'Ranged Combat': 15, 'Athletics': 10,
        }),
    RecommendedBuild(
        professionName: "Explorer",
        attributes: {'STR': 12, 'CON': 14, 'DEX': 14, 'INT': 11, 'WIL': 12, 'PER': 12},
        skillPointsToAdd: {
          'Survival': 35, 'Pilot': 25, 'Investigation': 20, 'Notice': 20, 'Medicine': 10,
          'Ranged Combat': 15, 'Athletics': 15, 'Mechanics': 10,
        }),
    RecommendedBuild(
        professionName: "Diplomat",
        attributes: {'STR': 8, 'CON': 10, 'DEX': 11, 'INT': 15, 'WIL': 16, 'PER': 15},
        skillPointsToAdd: {
          'Persuasion': 40, 'Deception': 25, 'Academics': 25, 'Notice': 10, 'Performance': 10,
          'Investigation': 15, 'Computers': 15, 'Streetwise': 10,
        }),
    RecommendedBuild(
        professionName: "Bounty Hunter",
        attributes: {'STR': 11, 'CON': 13, 'DEX': 15, 'INT': 12, 'WIL': 10, 'PER': 14},
        skillPointsToAdd: {
          'Investigation': 30, 'Ranged Combat': 30, 'Intimidation': 20, 'Survival': 15, 'Larceny': 15,
          'Streetwise': 15, 'Notice': 15, 'Stealth': 10,
        }),
    RecommendedBuild(
        professionName: "Xeno-Scientist",
        attributes: {'STR': 8, 'CON': 10, 'DEX': 12, 'INT': 17, 'WIL': 14, 'PER': 14},
        skillPointsToAdd: {
          'Xenology': 35, 'Academics': 25, 'Medicine': 25, 'Investigation': 20, 'Notice': 10,
          'Computers': 15, 'Survival': 10, 'Persuasion': 10,
        }),
    RecommendedBuild(
        professionName: "Navigator",
        attributes: {'STR': 9, 'CON': 10, 'DEX': 13, 'INT': 16, 'WIL': 13, 'PER': 14},
        skillPointsToAdd: {
          'Astrogation': 40, 'Computers': 30, 'Pilot': 20, 'Notice': 10, 'Academics': 10,
          'Mechanics': 15, 'Investigation': 15, 'Ranged Combat': 10,
        }),
    RecommendedBuild(
        professionName: "Hacker",
        attributes: {'STR': 9, 'CON': 10, 'DEX': 15, 'INT': 16, 'WIL': 12, 'PER': 13},
        skillPointsToAdd: {
          'Computers': 40, 'Investigation': 25, 'Stealth': 20, 'Mechanics': 15, 'Notice': 10,
          'Larceny': 15, 'Streetwise': 15, 'Deception': 10,
        }),
    RecommendedBuild(
        professionName: "Xeno-Ambassador",
        attributes: {'STR': 8, 'CON': 10, 'DEX': 11, 'INT': 16, 'WIL': 16, 'PER': 14},
        skillPointsToAdd: {
          'Xenology': 35, 'Persuasion': 30, 'Academics': 25, 'Notice': 10, 'Deception': 10,
          'Investigation': 15, 'Performance': 15, 'Computers': 10,
        }),
    // Fantasy
    RecommendedBuild(
        professionName: "Knight",
        attributes: {'STR': 15, 'CON': 14, 'DEX': 13, 'INT': 10, 'WIL': 12, 'PER': 11},
        skillPointsToAdd: {
          'Melee Combat': 35, 'Athletics': 25, 'Intimidation': 20, 'Ride': 15, 'Persuasion': 15,
          'Notice': 15, 'Survival': 15, 'Crafting': 10,
        }),
    RecommendedBuild(
        professionName: "Rogue",
        attributes: {'STR': 10, 'CON': 11, 'DEX': 17, 'INT': 14, 'WIL': 11, 'PER': 12},
        skillPointsToAdd: {
          'Stealth': 30, 'Larceny': 30, 'Athletics': 20, 'Melee Combat': 15, 'Investigation': 15,
          'Deception': 15, 'Notice': 15, 'Streetwise': 10,
        }),
    RecommendedBuild(
        professionName: "Wizard",
        attributes: {'STR': 8, 'CON': 11, 'DEX': 12, 'INT': 17, 'WIL': 14, 'PER': 13},
        skillPointsToAdd: {
          'Channeling': 35, 'Academics': 25, 'Lore': 25, 'Investigation': 20, 'Notice': 10,
          'Persuasion': 15, 'Medicine': 10, 'Stealth': 10,
        }),
    RecommendedBuild(
        professionName: "Ranger",
        attributes: {'STR': 11, 'CON': 13, 'DEX': 15, 'INT': 11, 'WIL': 12, 'PER': 13},
        skillPointsToAdd: {
          'Ranged Combat': 35, 'Survival': 30, 'Notice': 20, 'Melee Combat': 10, 'Investigation': 15,
          'Stealth': 15, 'Athletics': 15, 'Medicine': 10,
        }),
    RecommendedBuild(
        professionName: "Barbarian",
        attributes: {'STR': 17, 'CON': 15, 'DEX': 13, 'INT': 8, 'WIL': 12, 'PER': 10},
        skillPointsToAdd: {
          'Melee Combat': 35, 'Survival': 25, 'Intimidation': 25, 'Athletics': 20, 'Notice': 10,
          'Ranged Combat': 15, 'Stealth': 10, 'Larceny': 10,
        }),
    RecommendedBuild(
        professionName: "Priest",
        attributes: {'STR': 11, 'CON': 12, 'DEX': 10, 'INT': 14, 'WIL': 16, 'PER': 12},
        skillPointsToAdd: {
          'Channeling': 30, 'Persuasion': 30, 'Medicine': 25, 'Academics': 15, 'Investigation': 10,
          'Lore': 15, 'Intimidation': 15, 'Notice': 10,
        }),
    RecommendedBuild(
        professionName: "Squire",
        attributes: {'STR': 15, 'CON': 14, 'DEX': 13, 'INT': 10, 'WIL': 11, 'PER': 12},
        skillPointsToAdd: {
          'Melee Combat': 30, 'Ride': 25, 'Athletics': 25, 'Persuasion': 15, 'Crafting': 15,
          'Notice': 15, 'Survival': 15, 'Intimidation': 10,
        }),
    RecommendedBuild(
        professionName: "Alchemist",
        attributes: {'STR': 8, 'CON': 11, 'DEX': 12, 'INT': 16, 'WIL': 14, 'PER': 14},
        skillPointsToAdd: {
          'Crafting': 35, 'Academics': 25, 'Investigation': 20, 'Notice': 15, 'Deception': 15,
          'Medicine': 15, 'Larceny': 15, 'Stealth': 10,
        }),
    RecommendedBuild(
        professionName: "Scholar",
        attributes: {'STR': 8, 'CON': 10, 'DEX': 11, 'INT': 17, 'WIL': 15, 'PER': 14},
        skillPointsToAdd: {
          'Academics': 35, 'Lore': 30, 'Investigation': 25, 'Notice': 10, 'Persuasion': 10,
          'Medicine': 15, 'Deception': 15, 'Performance': 10,
        }),
  ];

  static final List<Spell> masterSpellList = [
    // Fantasy
    Spell(name: "Arcane Bolt", spCost: 2, description: "An unerring bolt of pure force strikes one target within 20 meters, dealing 1d8 damage that is not reduced by physical armor.", genres: [GameGenre.fantasy]),
    Spell(name: "Mending Touch", spCost: 3, description: "The caster touches a willing or unconscious creature, restoring 1d10 Hit Points.", genres: [GameGenre.fantasy]),
    Spell(name: "Mage Armor", spCost: 4, description: "Shimmering magical energy surrounds the caster for one hour, providing an Armor Value (AV) of 3. This does not stack with worn armor.", genres: [GameGenre.fantasy]),
    Spell(name: "Glimmer", spCost: 1, description: "A small orb of light appears, hovering near the caster. It illuminates a 10-meter radius and lasts for one hour.", genres: [GameGenre.fantasy]),
    Spell(name: "Fireball", spCost: 6, description: "A fiery explosion erupts at a point within 50 meters. Deals 3d8 damage to everything in a 5-meter radius. Targets can make an Athletics (Dodge) test to halve the damage.", genres: [GameGenre.fantasy]),
    Spell(name: "Invisibility", spCost: 5, description: "The caster becomes invisible for 10 minutes. The spell ends if the caster makes an attack or casts another spell.", genres: [GameGenre.fantasy]),
    Spell(name: "Ray of Frost", spCost: 2, description: "A beam of frigid cold hits one target within 15 meters, dealing 1d6 damage. The target must also pass a CON test or have their movement speed halved for their next turn.", genres: [GameGenre.fantasy]),
    Spell(name: "Fear", spCost: 4, description: "The caster makes an opposed Channeling test against one target within sight. On a success, the target is terrified and must use their next turn to move away from the caster.", genres: [GameGenre.fantasy]),
    Spell(name: "Mage Hand", spCost: 1, description: "A spectral, floating hand appears that can manipulate small objects (open doors, carry a key) at a distance of 10 meters for one minute.", genres: [GameGenre.fantasy]),
    Spell(name: "Haste", spCost: 7, description: "The caster touches a willing creature, granting them one additional Minor Action on each of their turns for 3 rounds.", genres: [GameGenre.fantasy]),
    Spell(name: "Lightning Bolt", spCost: 5, description: "A line of lightning 15 meters long and 1 meter wide shoots from the caster's hand, dealing 2d12 damage to all in its path. Ignores 2 points of AV.", genres: [GameGenre.fantasy]),
    Spell(name: "Speak with Animals", spCost: 3, description: "For one hour, the caster can comprehend and communicate with natural beasts.", genres: [GameGenre.fantasy]),

    // Sci-Fi
    Spell(name: "Telekinetic Shove", spCost: 2, description: "The psion targets one object or creature within 15 meters. The target must succeed on a Channeling test or be pushed 5 meters in a direction of the psion's choosing.", genres: [GameGenre.sciFi]),
    Spell(name: "Mind Scan", spCost: 3, description: "The psion may make an opposed Channeling test against one target within 10 meters. On a success, they can read the target's surface thoughts for one minute.", genres: [GameGenre.sciFi]),
    Spell(name: "Short Circuit", spCost: 4, description: "The psion targets one electronic device within 20 meters (e.g., a datapad, a laser rifle, a powered door). The device is rendered inoperable for 1d4 rounds.", genres: [GameGenre.sciFi]),
    Spell(name: "Precognitive Dodge", spCost: 5, description: "As a reaction to being attacked, the psion can activate this power to gain a +20 bonus to their next defensive test (Dodge or Parry).", genres: [GameGenre.sciFi]),
    Spell(name: "Mind Spike", spCost: 3, description: "The psion attacks the mind of one target within 20 meters, dealing 1d10 damage directly to their Resolve Points (RP). This damage is not reduced by armor.", genres: [GameGenre.sciFi]),
    Spell(name: "Kinetic Barrier", spCost: 6, description: "A shimmering field of force surrounds the psion for 5 minutes, providing an Armor Value (AV) of 4. This does not stack with worn armor.", genres: [GameGenre.sciFi]),
    Spell(name: "Adrenal Surge", spCost: 4, description: "The psion touches a willing creature, boosting their metabolism. For 3 rounds, the target gains a +2 bonus to STR and DEX.", genres: [GameGenre.sciFi]),
    Spell(name: "Psychic Scream", spCost: 7, description: "The psion unleashes a wave of mental force in a 10-meter cone. All targets in the area must pass a WIL test or be stunned for one round, unable to take actions.", genres: [GameGenre.sciFi]),
    Spell(name: "Techno-Scramble", spCost: 5, description: "The psion floods a 20-meter radius area with psychic static for one minute. All radio communication is jammed, and automated sensors (cameras, turrets) cease to function.", genres: [GameGenre.sciFi]),
    Spell(name: "Puppet", spCost: 8, description: "The psion makes an opposed Channeling test against one humanoid target. On a success, the psion may issue a single, simple verbal command (e.g., 'drop your weapon', 'open that door') which the target must obey on their next turn.", genres: [GameGenre.sciFi]),
    Spell(name: "Static Veil", spCost: 4, description: "For 10 minutes, the psion's energy signature is masked, giving them a +20 bonus on Stealth tests against electronic sensors.", genres: [GameGenre.sciFi]),
    Spell(name: "Bio-Heal", spCost: 3, description: "The psion uses telekinesis on a cellular level to knit wounds, restoring 1d10 Hit Points to a creature they are touching.", genres: [GameGenre.sciFi]),

    // Modern
    Spell(name: "Read Omens", spCost: 2, description: "By spending 10 minutes studying seemingly random patterns (tea leaves, cracks in the pavement, etc.), the caster can gain a cryptic but truthful clue about a single course of action.", genres: [GameGenre.modern]),
    Spell(name: "Curse of Misfortune", spCost: 4, description: "The caster makes an opposed Channeling test against one target within sight. On a success, the next time the target rolls a Percentile Test, they must swap their tens and units digit (e.g., a 27 becomes a 72).", genres: [GameGenre.modern]),
    Spell(name: "Whispers on the Wire", spCost: 3, description: "The caster can send a short, telepathic message (up to 10 words) to any person whose voice they have heard within the last 24 hours. The target perceives it as a faint whisper in their own mind.", genres: [GameGenre.modern]),
    Spell(name: "Veil of Normalcy", spCost: 5, description: "For one hour, the caster and up to two allies gain a +10 bonus to Stealth tests when in a crowd. People's eyes tend to slide past them, their minds registering nothing out of the ordinary.", genres: [GameGenre.modern]),
    Spell(name: "Psychometry", spCost: 2, description: "By handling an inanimate object for one minute, the caster can receive a vision of a single, strong emotional event that occurred in the object's past.", genres: [GameGenre.modern]),
    Spell(name: "Agonizing Affliction", spCost: 4, description: "The caster makes an opposed Channeling test against a target in sight. On a success, the target is wracked with unexplained pain, suffering a -10 penalty to all tests for 3 rounds.", genres: [GameGenre.modern]),
    Spell(name: "Binding Ward", spCost: 6, description: "The caster spends one minute creating an invisible seal on a door, window, or container. The first person to try and open it must pass a Hard Channeling test or be compelled to leave it alone.", genres: [GameGenre.modern]),
    Spell(name: "Compelling Voice", spCost: 5, description: "For the next minute, the caster gains a +20 bonus to their Persuasion skill tests.", genres: [GameGenre.modern]),
    Spell(name: "Ghost in the Machine", spCost: 3, description: "The caster can cause a short message (280 characters) to appear on any single electronic screen within sight, or cause a phone to ring with no one on the other end.", genres: [GameGenre.modern]),
    Spell(name: "Urban Camouflage", spCost: 4, description: "For one hour, while in an urban environment, the target blends into the background, gaining a +20 bonus to Stealth tests.", genres: [GameGenre.modern]),
    Spell(name: "Bad Penny", spCost: 7, description: "The caster curses a target they can see. For the next 24 hours, the target is plagued by minor inconveniences: their car won't start, their coffee is cold, their files corrupt. This imposes a -15 penalty on all tests that are not directly related to combat.", genres: [GameGenre.modern]),
    Spell(name: "Glimpse of the Void", spCost: 5, description: "The caster makes an opposed Channeling test against a target. On a success, the target perceives a fleeting, sanity-blasting image, forcing them to make a WIL test or become stunned for one round.", genres: [GameGenre.modern]),
    Spell(name: "Emotional Resonance", spCost: 4, description: "The caster makes an opposed Channeling test against one target in sight. On a success, the target becomes highly suggestible for one minute, granting the caster a +15 bonus on Persuasion or Intimidation tests against them.", genres: [GameGenre.modern]),
    Spell(name: "Scry for the Lost", spCost: 6, description: "Requires 10 minutes of ritualistic focus on a personal item linked to a lost object. On a successful Channeling test, the caster receives a brief, clear vision of the lost object's current location.", genres: [GameGenre.modern]),
    Spell(name: "Digital Echoes", spCost: 7, description: "The caster touches a destroyed electronic device and makes a Hard (half) Channeling test. On a success, they can perceive a single fragment of data from the device's last moments of operation (e.g., a final image, a snippet of audio, a line of text).", genres: [GameGenre.modern]),
    Spell(name: "Moment of Clarity", spCost: 2, description: "The caster spends 1 hour to center their mind and meditate. at the end of this meditation restore 1d8 of their own lost Resolve Points (RP).", genres: [GameGenre.modern]),
    Spell(name: "Unsettling Presence", spCost: 4, description: "The caster fills a single room with an aura of dread for one hour. Anyone who enters must make a Channeling test. On a failure, they are deeply unnerved and will refuse to enter or will leave as soon as possible.", genres: [GameGenre.modern]),
    Spell(name: "Seize the Moment", spCost: 6, description: "As a minor action, the caster can prepare to twist fate. At any point within the next minute, they may choose to reroll a single failed Percentile Test they have just made.", genres: [GameGenre.modern]),
    Spell(name: "Imbue with Malice", spCost: 3, description: "The caster touches a single mundane melee weapon (e.g., a knife, a baseball bat). For one minute, the weapon's attacks ignore 2 points of Armor Value (AV).", genres: [GameGenre.modern]),
    Spell(name: "Fading Memory", spCost: 9, description: "The caster makes an opposed Channeling test against a target they are touching. On a success, the target completely forgets the events of the last 1d4 Hours.", genres: [GameGenre.modern]),
    Spell(name: "Sympathetic Agony", spCost: 5, description: "Requires a personal belonging of the target (hair, business card, etc.). The caster makes a Channeling test to inflict pain from afar. The target takes 1d6 damage that ignores armor and feels like a sudden migraine or muscle tear. this cannot kill the target", genres: [GameGenre.modern]),
    Spell(name: "A Face in the Crowd", spCost: 5, description: "For one hour, the caster's facial features become bland and unmemorable. Anyone trying to recall their appearance must pass a Hard (half) PER test. This grants a +20 bonus to Stealth tests when in a group of three or more people.", genres: [GameGenre.modern]),
    Spell(name: "Static Ward", spCost: 7, description: "The caster performs a 10-minute ritual on an object, room, or willing person. For 24 hours, the target is completely shielded from magical scrying, divination, and remote surveillance.", genres: [GameGenre.modern]),
    Spell(name: "Urban Stride", spCost: 3, description: "For 10 minutes, the caster sees the city as a set of pathways. They gain a +20 bonus to Athletics tests made to climb, leap between rooftops, or balance on narrow ledges.", genres: [GameGenre.modern]),
    Spell(name: "Heightened Senses", spCost: 4, description: "The caster's senses sharpen to a supernatural degree for one minute. They gain a +30 bonus to all Notice skill tests for the duration.", genres: [GameGenre.modern]),
    Spell(name: "Cognitive Scramble", spCost: 6, description: "Make an opposed Channeling test against one target in sight. On a success, the target's thoughts become a jumble for 1d4 rounds. To perform any Major Action, they must first pass an INT test or the action is wasted.", genres: [GameGenre.modern]),
    Spell(name: "Summon Coincidence", spCost: 5, description: "The caster makes a Channeling test to nudge the universe. On a success, they can create a minor, plausible environmental distraction within sight (a car alarm starts blaring, a streetlight flickers out, a sudden gust of wind kicks up dust).", genres: [GameGenre.modern]),
    Spell(name: "Blood Price", spCost: 1, description: "As a minor action, the caster sacrifices their own vitality. They take up to 5 HP of damage, and for each point of HP lost, they gain a +5 bonus to their next Channeling test made this turn.", genres: [GameGenre.modern]),
    Spell(name: "Curse of the Jammed Mechanism", spCost: 4, description: "The caster places a minor curse on a single mechanical device (a gun, a car engine, a locked door). The next time the device is used, it automatically fails in a critical way. Requires a Mechanics test to fix.", genres: [GameGenre.modern]),
    Spell(name: "Truth's Itch", spCost: 3, description: "Make an opposed Channeling test against one target. For the next 5 minutes, if the target tells a direct lie, they develop a distracting and obvious physical tic, imposing a -20 penalty on their Deception tests.", genres: [GameGenre.modern]),
    Spell(name: "Mental Fortress", spCost: 4, description: "The caster erects a psychic shield that lasts for one hour. They gain a +20 bonus to any opposed test to resist mental intrusion, illusions, or emotional manipulation.", genres: [GameGenre.modern]),
  ];


  static final List<Weapon> masterWeaponList = [
    // Melee
    Weapon(name: "Unarmed", damage: "1d4-1 + STR/2", genres: [GameGenre.fantasy, GameGenre.modern, GameGenre.sciFi]),
    Weapon(name: "Brass Knuckles", damage: "1d4 + STR/2", notes: "Can be concealed", genres: [GameGenre.modern]),
    Weapon(name: "Knife", damage: "1d6 + STR/2", notes: "Can be thrown", genres: [GameGenre.fantasy, GameGenre.modern, GameGenre.sciFi]),
    Weapon(name: "Dagger", damage: "1d6 + STR/2", notes: "Can be thrown", genres: [GameGenre.fantasy]),
    Weapon(name: "Club / Bat", damage: "1d8 + STR/2", genres: [GameGenre.fantasy, GameGenre.modern]),
    Weapon(name: "Shortsword", damage: "1d8 + STR/2", genres: [GameGenre.fantasy]),
    Weapon(name: "Longsword", damage: "1d10 + STR/2", notes: "Requires two hands for full bonus", genres: [GameGenre.fantasy]),
    Weapon(name: "Battle Axe", damage: "1d10 + STR/2", notes: "Sunder (damages armor on Crit)", genres: [GameGenre.fantasy]),
    Weapon(name: "Halberd/Spear", damage: "1d10 + STR/2", notes: "Two-handed, Reach", genres: [GameGenre.fantasy]),
    Weapon(name: "Great Axe", damage: "1d12 + STR/2", notes: "Two-handed, clumsy (-5 to Parry)", genres: [GameGenre.fantasy]),
    Weapon(name: "Greatsword", damage: "1d12 + STR/2", notes: "Two-handed", genres: [GameGenre.fantasy]),
    Weapon(name: "Quarterstaff", damage: "1d8 + STR/2", notes: "Two-handed, Defensive (+1 Parry)", genres: [GameGenre.fantasy]),
    Weapon(name: "Stun Baton", damage: "1d6 + STR/2", notes: "Modern, Electric (CON test or stun)", genres: [GameGenre.modern, GameGenre.sciFi]),
    Weapon(name: "Vibro-blade", damage: "2d8", notes: "Sci-fi, ignores 2 points of armor", genres: [GameGenre.sciFi]),
    Weapon(name: "Power Fist", damage: "2d10", notes: "Sci-fi, Powered, Unwieldy", genres: [GameGenre.sciFi]),
    // Ranged
    Weapon(name: "Throwing Knife", damage: "1d6", notes: "Range: 5/10/20m", genres: [GameGenre.fantasy, GameGenre.modern]),
    Weapon(name: "Shortbow", damage: "1d8", notes: "Range: 20/40/80m", genres: [GameGenre.fantasy]),
    Weapon(name: "Longbow", damage: "1d10", notes: "Range: 50/100/200m", genres: [GameGenre.fantasy]),
    Weapon(name: "Crossbow", damage: "1d12", notes: "Range: 30/60/120m, Slow Reload (1 Major Action)", genres: [GameGenre.fantasy]),
    Weapon(name: "Light Pistol", damage: "1d10", notes: "Range: 15/30/60m, Modern, Semi-auto", genres: [GameGenre.modern]),
    Weapon(name: "Heavy Pistol", damage: "1d12", notes: "Range: 20/40/80m, Modern, High recoil (-5 if STR < 12)", genres: [GameGenre.modern]),
    Weapon(name: "Submachine Gun", damage: "1d10", notes: "Range: 20/40/80m, Modern, Burst-fire", genres: [GameGenre.modern, GameGenre.sciFi]),
    Weapon(name: "Shotgun", damage: "2d10", notes: "Range: 10/20/40m, Modern, +5 to hit at Short range", genres: [GameGenre.modern]),
    Weapon(name: "Assault Rifle", damage: "2d8", notes: "Range: 100/200/400m, Modern, Burst-fire", genres: [GameGenre.modern, GameGenre.sciFi]),
    Weapon(name: "Sniper Rifle", damage: "2d12", notes: "Range: 200/400/800m, Modern, Requires Aiming", genres: [GameGenre.modern]),
    Weapon(name: "Laser Pistol", damage: "2d6", notes: "Range: 30/60/120m, Sci-fi, Ignores 1 AV", genres: [GameGenre.sciFi]),
    Weapon(name: "Laser Rifle", damage: "2d8", notes: "Range: 150/300/600m, Sci-fi, Ignores 1 AV", genres: [GameGenre.sciFi]),
    Weapon(name: "Plasma Rifle", damage: "3d8", notes: "Range: 80/160/320m, Sci-fi, High energy use", genres: [GameGenre.sciFi]),
    Weapon(name: "Grenade Launcher", damage: "Varies", notes: "Range: 50/100/150m, Modern, Fires grenades", genres: [GameGenre.modern]),
  ];

  static final List<Armor> masterArmorList = [
    Armor(name: "Padded / Leather", armorValue: 1, genres: [GameGenre.fantasy]),
    Armor(name: "Synth-Leather", armorValue: 2, notes: "Sci-fi / Modern, often stylish", genres: [GameGenre.modern, GameGenre.sciFi]),
    Armor(name: "Chainmail", armorValue: 3, notes: "Fantasy, Noisy (-10 Stealth)", genres: [GameGenre.fantasy]),
    Armor(name: "Plate Armor", armorValue: 5, notes: "Fantasy, Cumbersome (-10 Athletics)", genres: [GameGenre.fantasy]),
    Armor(name: "Shield", armorValue: 0, notes: "Provides +10 to Parry tests", genres: [GameGenre.fantasy]),
    Armor(name: "Ballistic Vest", armorValue: 3, notes: "Modern, Protects Torso only", genres: [GameGenre.modern]),
    Armor(name: "Riot Gear", armorValue: 4, notes: "Modern, Full Body, Cumbersome", genres: [GameGenre.modern]),
    Armor(name: "Combat Armor", armorValue: 4, notes: "Modern / Sci-fi, Full body suit", genres: [GameGenre.modern, GameGenre.sciFi]),
    Armor(name: "Ablative Plates", armorValue: 5, notes: "Sci-fi, AV degrades as it takes hits", genres: [GameGenre.sciFi]),
    Armor(name: "Flight Suit", armorValue: 2, notes: "Sealed, provides life support", genres: [GameGenre.sciFi]),
    Armor(name: "Powered Armor", armorValue: 6, notes: "Sci-fi, Requires power source, +2 STR", genres: [GameGenre.sciFi]),
  ];

  static List<Race> getRacesForGenre(GameGenre genre) {
    switch (genre) {
      case GameGenre.fantasy:
        return races.where((r) => ['Human', 'Elf', 'Dwarf', 'Orc'].contains(r.name)).toList();
      case GameGenre.sciFi:
        return races.where((r) => ['Human', 'Cygnian', 'Saurian', 'Gremlin'].contains(r.name)).toList();
      case GameGenre.modern:
        return races.where((r) => r.name == 'Human').toList();
    }
  }

  static List<Profession> getProfessionsForGenre(GameGenre genre) {
    return professions.where((p) => p.genre == genre).toList();
  }

  static List<Weapon> getWeaponsForGenre(GameGenre genre) {
    return masterWeaponList.where((w) => w.genres.contains(genre)).toList();
  }

  static List<Armor> getArmorForGenre(GameGenre genre) {
    return masterArmorList.where((a) => a.genres.contains(genre)).toList();
  }

  static List<Spell> getSpellsForGenre(GameGenre genre) {
    return masterSpellList.where((s) => s.genres.contains(genre)).toList();
  }
}