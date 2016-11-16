
fileObjOut = File.open("output01.txt")
fileObj = File.open("input01.txt")

# Extração de Dados
t =  1000
fileObj.gets.to_i
w = []
word = []
w_char = []
w_char2 = []
for j in 0...t
	i = fileObj.gets
	i = i[0..-2].split("")
	w_char.push(i)
end
for j2 in 0...t
	i2 = fileObjOut.gets
	i2 = i2[0..-2].split("")
	w_char2.push(i2)
end
# Fim extração de Dados

@errors = 0
@ok = 0	
def valida(my_output,output)
	if my_output == output.join
		print my_output
		puts
		@ok += 1
	else
		puts "==================="
		print my_output
		puts "vs"
		print output.join
		puts
		puts "==================="
		@errors += 1
	end
end

for n in (0...t)
    new_i = []
    arr_len = w_char[n].count-1
    counter = 1
    
    if w_char[n].uniq.count == 1
        valida("no answer",w_char2[n])
	
	elsif w_char[n][-1] > w_char[n][-2]
		if w_char.count > 2
			res = "#{w_char[n][0..-3].join}#{w_char[n][-1]}#{w_char[n][-2]}"
			valida(res,w_char2[n])
		else w_char.count <= 2
			res = "#{w_char[n][-1]}#{w_char[n][-2]}" 
			valida(res,w_char2[n])
		end
	
	else
		for i in 0...w_char[n].count
			w_char[n][arr_len-i] > w_char[n][arr_len-i-1] ? break : counter += 1
		end
		if arr_len == counter
			aux1 = Array.new
			aux1 = w_char[n].select {|x| x > w_char[n][arr_len-counter]}
			aux2 = Array.new(w_char[n])
			aux2.sort!.delete_at(aux2.index(aux1.sort![0]))
			res = "#{aux1.sort![0]}#{aux2.join}"
			valida(res,w_char2[n])
		elsif arr_len > counter
			aux1 = Array.new
			aux1 = w_char[n][arr_len-counter+1..arr_len].select {|x| x > w_char[n][arr_len-counter]}
			aux2 = Array.new(w_char[n][(arr_len-counter)..arr_len])
			aux2.sort!.delete_at(aux2.index(aux1.sort![0]))
			res = "#{w_char[n][0..arr_len-counter-1].join}#{aux1.sort![0]}#{aux2.join}"
			valida(res,w_char2[n])
		else
			valida("no answer",w_char2[n])
		end	
	end
end

puts "----------------------------------------"
puts "Report:"
puts "Ok : #{@ok}"
puts "Errors : #{@errors}"

fileObj.close
fileObjOut.close
