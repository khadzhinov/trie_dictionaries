class TrieNode
  attr_accessor :children, :is_end_of_word

  def initialize
    @children = {}
    @is_end_of_word = false
  end
end

class Trie
  attr_accessor :root

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
  s.downcase!
  d.each { |word| trie.insert(word.downcase) }
  n = s.length
  dp = Array.new(n + 1, false)

  node = trie.root
  (1..n).each do |i|
    (i - 1).downto(0) do |j|
      char = s[j]
      if node.children[char]
        node = node.children[char]
        if node.is_end_of_word
          dp[i] = true
          node = trie.root
          break
        end
      else
        break
      end
    end
  end

  dp[n]
end

s = 'модернистский роман ирландского писателя Джеймса Джойса Улиcc'
d = %w[модернистский роман ирландского писателя джеймса джойса улисс]
result = can_segment_string(s, d)
puts result # false

s = 'модернистский роман ирландского писателя Джеймса Джойса Улисс'
d = %w[модернистский роман ирландского писателя джеймса джойса улисс]
result = can_segment_string(s, d)
puts result # true

s = 'дoсотентысяч'
d = %w[дo сотен тысяч]
result = can_segment_string(s, d)
puts result # true

s = 'двесотни'
d = %w[две сотни тысячи]
result = can_segment_string(s, d)
puts result # true

s2 = 'двесотня'
d2 = %w[две сотня тысячи]
result2 = can_segment_string(s2, d2)
puts result2 # true

s3 = 'дветысячи'
d3 = %w[две сотня тысячи]
result3 = can_segment_string(s3, d3)
puts result3 # true

s3 = 'двесотни'
d3 = %w[две сотня тысячи]
result3 = can_segment_string(s3, d3)
puts result3 # false

s3 = 'сотня'
d3 = %w[две сотня тысячи]
result3 = can_segment_string(s3, d3)
puts result3 # true

s3 = 'две сотня тысяч'
d3 = %w[две сотня тысячи]
result3 = can_segment_string(s3, d3)
puts result3 # false

s3 = 'две сотня тысяч'
d3 = %w[две сотня тысяч]
result3 = can_segment_string(s3, d3)
puts result3 # true
