require_relative 'path'

module GraphMatching

  class Matching

    # Gabow (1976) uses a simple array to store his matching.  It
    # has one element for each vertex in the graph.  The value of
    # each element is either the number of another vertex (Gabow
    # uses sequential integers for vertex numbering) or a zero if
    # unmatched.  So, `.gabow` returns a `Matching` initialized
    # from such an array.
    def self.gabow(mate)
      m = new
      mate.each_with_index do |n1, ix|
        if !n1.nil? && n1 != 0
          n2 = mate[n1]
          if n2 == ix
            m.add([n1, n2])
          end
        end
      end
      m
    end

    def self.[](*edges)
      new.tap { |m| edges.each { |e| m.add(e) } }
    end

    def initialize
      @ary = []
    end

    def [](i)
      @ary[i]
    end

    def add(e)
      i, j = e
      @ary[i] = j
      @ary[j] = i
    end

    def delete(e)
      i, j = e
      @ary[i] = nil
      @ary[j] = nil
    end

    def empty?
      @ary.all?(&:nil?)
    end

    def has_edge?(e)
      i, j = e
      !@ary[i].nil? && @ary[i] == j && @ary[j] == i
    end

    def has_vertex?(v)
      @ary.include?(v)
    end

    # `size` returns number of edges
    def size
      @ary.compact.size / 2
    end

    def to_a
      result = []
      skip = []
      @ary.each_with_index { |e, i|
        unless e.nil? || skip.include?(i)
          result << [i, e]
          skip << e
        end
      }
      result
    end

    def vertexes
      @ary.compact
    end

  end
end
