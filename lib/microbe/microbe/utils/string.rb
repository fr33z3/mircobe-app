module Microbe
  module Utils
    class String < SimpleDelegator
      PLURALIZE_EXCEPTIONS = {
        "child" => "children",
        "ox" => "oxen",
        "tooth" => "teeth",
        "foot" => "feet",
        "person" => "people",
        "index" => "indices",
        "matrix" => "matrices",
        "vertex" => "vertices",
        "radius" => "radii",
        "automaton" => "automata",
        "alumnus" => "alumni",
        "axis" => "axes",
        "mouse" => "mice",
        "goose" => "geese",
        "cactus" => "cacti",
        "focus" => "foci",
        "fungus" => "fungi",
        "nucleus" => "nuclei",
        "bacterium" => "bacteria",
        "stimulus" => "stimuli",
        "syllabus" => "syllabi",
        "phenomenon" => "phenomena",
        "criterion" => "criteria",
        "datum" => "data"
      }.freeze

      UNCOUNTABLE_WORDS = %w(sheep fish deer bison buffalo moose salmon squid trout
                             series species aircraft watercraft spacecraft hovercraft).freeze
      VOWELS = %w(a e i o u).freeze

      def pluralize
        if PLURALIZE_EXCEPTIONS.keys.include?(self)
          PLURALIZE_EXCEPTIONS[self]
        elsif UNCOUNTABLE_WORDS.include?(self)
          __getobj__
        elsif self[-3, 3] == "man"
          self[0, length - 3] + "men"
        elsif self[-3, 3] == "sis"
          self[0, length - 3] + "ses"
        elsif VOWELS.include?(self[-2, 1]) && %w(y o).include?(self[-1, 1])
          self + s
        elsif !VOWELS.include?(self[-2, 1]) && self[-1, 1] == "y"
          self[0, length - 1] + "ies"
        elsif !VOWELS.include?(self[-2, 1]) && self[-1, 1] == "o"
          self[0, length - 1] + "es"
        elsif self[-1, 1] == "f"
          self[0, length - 1] + "ves"
        elsif self[-2, 2] == "fe"
          self[0, length - 2] + "ves"
        elsif %w(s x z).include?(self[-1,1]) || %w(ss sh ch).include?(self[-2, 2])
          self + "es"
        else
          __getobj__ + "s"
        end
      end

      def underscore
        (0..size-1).inject("") do |res, i|
          if ('A'..'Z').include?(self[i])
            res += "_" if i > 0 && res[-1] != "_"
            res += self[i].downcase
          else
            res += self[i]
          end
        end
      end
    end
  end
end
