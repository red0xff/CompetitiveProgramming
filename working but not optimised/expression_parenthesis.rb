=begin
INPUT FORMAT:
The arithmetic expression, a space should separate each 'token' in the expression (example: "5 - x + 43 * y1")
This program prints all the valid expressions that can be obtained from the given one by adding parenthesis
=end

class Array
	def parenthesis
		if self.count <= 2
			[self];
		elsif self.count == 3
			[self, [?(] + self + [?)]];
		else
			self[0 .. -5].parenthesis.map{|e| e + [self[-4]] + [?(] + self[-3..-1] + [?)]} + 
			self[0 .. -3].parenthesis.map{|e| e + self[-2 .. -1]};
		end
	end
end

gets.chomp.split(' ').parenthesis.each do|expr|
	puts expr.join;
end
