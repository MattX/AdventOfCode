### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 93332e72-34b3-11eb-3bd8-a70cf8508b17
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 22bb8542-34b4-11eb-3f22-fdcc758b647e
line_regex = r"(?<min>[0-9]+)-(?<max>[0-9]+) (?<letter>[a-z]): (?<password>[a-z]*)"

# ╔═╡ 3f28c4da-34b4-11eb-25d4-9b493092b2bc
function valid_line(line)
	m = match(line_regex, line)
	min, max, letter, password = parse(Int, m[:min]), parse(Int, m[:max]), m[:letter][1], m[:password]
	cnt = count(x -> x==letter, password)
	return cnt >= min && cnt <= max
end

# ╔═╡ 81438bde-34b4-11eb-0c52-41dafb009f98
valid_line_count = count(valid_line, lines)

# ╔═╡ 3acd3a60-34b4-11eb-2dc0-d129545a568b
function valid_line2(line)
	m = match(line_regex, line)
	first, second, letter, password = parse(Int, m[:min]), parse(Int, m[:max]), m[:letter][1], m[:password]
	return (password[first] == letter || password[second] == letter) && password[first] != password[second]
end

# ╔═╡ fbb78556-34bd-11eb-3553-a9f43f19eb9d
valid_line_count2 = count(valid_line2, lines)

# ╔═╡ Cell order:
# ╠═93332e72-34b3-11eb-3bd8-a70cf8508b17
# ╠═22bb8542-34b4-11eb-3f22-fdcc758b647e
# ╠═3f28c4da-34b4-11eb-25d4-9b493092b2bc
# ╠═81438bde-34b4-11eb-0c52-41dafb009f98
# ╠═3acd3a60-34b4-11eb-2dc0-d129545a568b
# ╠═fbb78556-34bd-11eb-3553-a9f43f19eb9d
