# frozen_string_literal: true

module Philiprehberger
  module Pluralize
    # Pluralization and singularization rules for English words
    module Rules
      PLURALS = [
        [/$/, 's'],
        [/s$/i, 's'],
        [/^(ax|test)is$/i, '\1es'],
        [/(octop|vir)us$/i, '\1i'],
        [/(octop|vir)i$/i, '\1i'],
        [/(alias|status)$/i, '\1es'],
        [/(bu|mis|gas)s$/i, '\1ses'],
        [/(buffal|tomat)o$/i, '\1oes'],
        [/([ti])um$/i, '\1a'],
        [/([ti])a$/i, '\1a'],
        [/sis$/i, 'ses'],
        [/(?:([^f])fe|([lr])f)$/i, '\1\2ves'],
        [/(hive)$/i, '\1s'],
        [/([^aeiouy]|qu)y$/i, '\1ies'],
        [/(x|ch|ss|sh)$/i, '\1es'],
        [/(matr|vert|append)ix|ice$/i, '\1ices'],
        [/^(m|l)ouse$/i, '\1ice'],
        [/^(m|l)ice$/i, '\1ice'],
        [/^(ox)$/i, '\1en'],
        [/^(oxen)$/i, '\1'],
        [/(quiz)$/i, '\1zes'],
        [/([m|l])an$/i, '\1en'],
        [/([m|l])en$/i, '\1en'],
        [/^(pe)(rson|ople)$/i, '\1ople'],
        [/(child)(ren)?$/i, '\1ren'],
        [/^(g)(oose|eese)$/i, '\1eese'],
        [/^(t)(ooth|eeth)$/i, '\1eeth'],
        [/^(f)(oot|eet)$/i, '\1eet'],
        [/(phenomen|criteri)on$/i, '\1a'],
        [/(phenomen|criteri)a$/i, '\1a'],
        [/^(d)(atum|ata)$/i, '\1ata'],
        [/^(cact)(us|i)$/i, '\1i'],
        [/^(fung)(us|i)$/i, '\1i'],
        [/^(nucle)(us|i)$/i, '\1i'],
        [/^(syllab)(us|i)$/i, '\1i'],
        [/^(foc)(us|i)$/i, '\1i'],
        [/^(stimul)(us|i)$/i, '\1i'],
        [/^(alumn)(us|i)$/i, '\1i'],
        [/^(radi)(us|i)$/i, '\1i'],
        [/^(ind)(ex|ices)$/i, '\1ices'],
        [/^(vert)(ex|ices)$/i, '\1ices'],
        [/^(matr)(ix|ices)$/i, '\1ices'],
        [/(elf)$/i, 'elves'],
        [/(elves)$/i, 'elves'],
        [/(half)$/i, 'halves'],
        [/(halves)$/i, 'halves'],
        [/(leaf)$/i, 'leaves'],
        [/(leaves)$/i, 'leaves'],
        [/(loaf)$/i, 'loaves'],
        [/(loaves)$/i, 'loaves'],
        [/(thief)$/i, 'thieves'],
        [/(thieves)$/i, 'thieves'],
        [/(wolf)$/i, 'wolves'],
        [/(wolves)$/i, 'wolves'],
        [/(wife)$/i, 'wives'],
        [/(wives)$/i, 'wives'],
        [/(knife)$/i, 'knives'],
        [/(knives)$/i, 'knives'],
        [/(life)$/i, 'lives'],
        [/(lives)$/i, 'lives'],
        [/(dwarf)$/i, 'dwarves'],
        [/(dwarves)$/i, 'dwarves'],
        [/(scarf)$/i, 'scarves'],
        [/(scarves)$/i, 'scarves'],
        [/(hero)$/i, 'heroes'],
        [/(heroes)$/i, 'heroes'],
        [/(potato)$/i, 'potatoes'],
        [/(potatoes)$/i, 'potatoes'],
        [/(volcano)$/i, 'volcanoes'],
        [/(volcanoes)$/i, 'volcanoes'],
        [/(tornado)$/i, 'tornadoes'],
        [/(tornadoes)$/i, 'tornadoes'],
        [/(echo)$/i, 'echoes'],
        [/(echoes)$/i, 'echoes'],
        [/(embargo)$/i, 'embargoes'],
        [/(embargoes)$/i, 'embargoes'],
        [/(mosquito)$/i, 'mosquitoes'],
        [/(mosquitoes)$/i, 'mosquitoes']
      ].freeze

      SINGULARS = [
        [/s$/i, ''],
        [/(ss)$/i, '\1'],
        [/(news)$/i, '\1'],
        [/([ti])a$/i, '\1um'],
        [/((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)(ses|sis)$/i, '\1sis'],
        [/(^analy)(ses|sis)$/i, '\1sis'],
        [/([^f])ves$/i, '\1fe'],
        [/(hive)s$/i, '\1'],
        [/(tive)s$/i, '\1'],
        [/([lr])ves$/i, '\1f'],
        [/([^aeiouy]|qu)ies$/i, '\1y'],
        [/(s)eries$/i, '\1eries'],
        [/(m)ovies$/i, '\1ovie'],
        [/(x|ch|ss|sh)es$/i, '\1'],
        [/^(m|l)ice$/i, '\1ouse'],
        [/(bus)(es)?$/i, '\1'],
        [/(o)es$/i, '\1'],
        [/(shoe)s$/i, '\1'],
        [/(cris|test)(is|es)$/i, '\1is'],
        [/^(a)x[ie]s$/i, '\1xis'],
        [/(octop|vir)(us|i)$/i, '\1us'],
        [/(alias|status)(es)?$/i, '\1'],
        [/^(ox)en/i, '\1'],
        [/(vert|ind)ices$/i, '\1ex'],
        [/(matr)ices$/i, '\1ix'],
        [/(quiz)zes$/i, '\1'],
        [/(database)s$/i, '\1'],
        [/([m|l])en$/i, '\1an'],
        [/^(pe)(ople|rson)$/i, '\1rson'],
        [/(child)(ren)?$/i, '\1'],
        [/^(g)(eese|oose)$/i, '\1oose'],
        [/^(t)(eeth|ooth)$/i, '\1ooth'],
        [/^(f)(eet|oot)$/i, '\1oot'],
        [/(phenomen|criteri)a$/i, '\1on'],
        [/^(d)(ata|atum)$/i, '\1atum'],
        [/^(cact)(i|us)$/i, '\1us'],
        [/^(fung)(i|us)$/i, '\1us'],
        [/^(nucle)(i|us)$/i, '\1us'],
        [/^(syllab)(i|us)$/i, '\1us'],
        [/^(foc)(i|us)$/i, '\1us'],
        [/^(stimul)(i|us)$/i, '\1us'],
        [/^(alumn)(i|us)$/i, '\1us'],
        [/^(radi)(i|us)$/i, '\1us'],
        [/^(ind)(ices|ex)$/i, '\1ex'],
        [/^(vert)(ices|ex)$/i, '\1ex'],
        [/^(matr)(ices|ix)$/i, '\1ix'],
        [/(elves)$/i, 'elf'],
        [/(halves)$/i, 'half'],
        [/(leaves)$/i, 'leaf'],
        [/(loaves)$/i, 'loaf'],
        [/(thieves)$/i, 'thief'],
        [/(wolves)$/i, 'wolf'],
        [/(wives)$/i, 'wife'],
        [/(knives)$/i, 'knife'],
        [/(lives)$/i, 'life'],
        [/(dwarves)$/i, 'dwarf'],
        [/(scarves)$/i, 'scarf'],
        [/(heroes)$/i, 'hero'],
        [/(potatoes)$/i, 'potato'],
        [/(volcanoes)$/i, 'volcano'],
        [/(tornadoes)$/i, 'tornado'],
        [/(echoes)$/i, 'echo'],
        [/(embargoes)$/i, 'embargo'],
        [/(mosquitoes)$/i, 'mosquito']
      ].freeze

      IRREGULARS = {
        'person' => 'people',
        'man' => 'men',
        'woman' => 'women',
        'child' => 'children',
        'sex' => 'sexes',
        'move' => 'moves',
        'zombie' => 'zombies',
        'goose' => 'geese',
        'mouse' => 'mice',
        'tooth' => 'teeth',
        'foot' => 'feet',
        'ox' => 'oxen',
        'louse' => 'lice',
        'criterion' => 'criteria',
        'phenomenon' => 'phenomena',
        'datum' => 'data',
        'cactus' => 'cacti',
        'focus' => 'foci',
        'fungus' => 'fungi',
        'nucleus' => 'nuclei',
        'syllabus' => 'syllabi',
        'radius' => 'radii',
        'alumnus' => 'alumni',
        'stimulus' => 'stimuli',
        'octopus' => 'octopi',
        'virus' => 'viri',
        'index' => 'indices',
        'vertex' => 'vertices',
        'matrix' => 'matrices',
        'quiz' => 'quizzes'
      }.freeze

      UNCOUNTABLES = Set.new(%w[
                               equipment
                               information
                               rice
                               money
                               species
                               series
                               fish
                               sheep
                               jeans
                               police
                               deer
                               moose
                               offspring
                               aircraft
                               salmon
                               trout
                               swine
                               bison
                               buffalo
                               elk
                               shrimp
                               plankton
                               squid
                               tuna
                               cod
                               means
                               news
                               mathematics
                               physics
                               economics
                               ethics
                               politics
                               athletics
                               linguistics
                               gymnastics
                               electronics
                               aeronautics
                               statistics
                               semantics
                               logistics
                               diabetes
                               herpes
                               measles
                               mumps
                               rabies
                               scissors
                               pants
                               shorts
                               glasses
                               tweezers
                               pliers
                               tongs
                               headquarters
                               barracks
                               gallows
                               crossroads
                               innings
                               chassis
                               corps
                               debris
                               kudos
                               molasses
                               shambles
                               premises
                             ]).freeze
    end
  end
end
