class TrieNode
  attr_accessor :children, :is_end_of_word

  def initialize
    @children = {}
    @is_end_of_word = false
  end
end

class Trie
  def initialize
    @root = TrieNode.new
  end

  def insert(word)
    node = @root
    word.each_char do |char|
      node.children[char] ||= TrieNode.new
      node = node.children[char]
    end
    node.is_end_of_word = true
  end

  def search(word)
    node = @root
    word.each_char do |char|
      return false unless node.children[char]
      node = node.children[char]
    end
    node.is_end_of_word
  end
end

def can_segment_string(s, d)
  trie = Trie.new
  d.each { |word| trie.insert(word) }
  n = s.length
  dp = Array.new(n + 1, false)
  dp[0] = true

  (1..n).each do |i|
    node = trie.root
    (i - 1).downto(0) do |j|
      char = s[j]
      if node.children[char]
        node = node.children[char]
        if node.is_end_of_word && dp[j]
          dp[i] = true
          break
        end
      else
        break
      end
    end
  end

  dp[n]
end

s = "двесотни"
d = %w[две сотни тысячи]
result = can_segment_string(s, d)
puts result

# Другой пример
s2 = "двесотня"
d2 = %w[две сотня тысячи]
result2 = can_segment_string(s2, d2)
puts result2