### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ de5bb764-3924-11eb-2482-2f00fd516562
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 1cb367f0-3925-11eb-32c4-01cbefd62f2a
function run_lines(lines)
	executed = zeros(Bool, size(lines))
	acc = 0
	l = 1
	while true
		if executed[l]
			return acc
		end
		executed[l] = true
		instr, arg = tuple(split(lines[l])...)
		arg = parse(Int, arg)
		if instr == "acc"
			acc += arg
		elseif instr == "jmp"
			l += arg
			continue
		end
		l += 1
	end
end

# ╔═╡ 8fea65f2-3925-11eb-1550-432cadeb63ca
run_lines(lines)

# ╔═╡ e3ddca78-3925-11eb-37e6-67804e9df878
function run_normal(lines)
	executed = zeros(Bool, size(lines))
	acc = 0
	l = 1
	while true
		if l > length(lines)
			return acc
		end
		if executed[l]
			return false
		end
		executed[l] = true
		instr, arg = tuple(split(lines[l])...)
		arg = parse(Int, arg)
		if instr == "acc"
			acc += arg
		elseif instr == "jmp"
			l += arg
			continue
		end
		l += 1
	end
end

# ╔═╡ 127cfe26-3926-11eb-09be-5d022c22b8e7
function find_valid(lines)
	for i in eachindex(lines)
		instr, arg = tuple(split(lines[i])...)
		if instr == "acc"
			continue
		elseif instr == "nop"
			rinstr = "jmp"
		else
			rinstr = "nop"
		end
		newlines = copy(lines)
		newlines[i] = string(rinstr, " ", arg)
		ret = run_normal(newlines)
		if ret != false
			return ret
		end
	end
end

# ╔═╡ 95e8f9a4-3926-11eb-1f22-4fcbabfb16ba
find_valid(lines)

# ╔═╡ Cell order:
# ╠═de5bb764-3924-11eb-2482-2f00fd516562
# ╠═1cb367f0-3925-11eb-32c4-01cbefd62f2a
# ╠═8fea65f2-3925-11eb-1550-432cadeb63ca
# ╠═e3ddca78-3925-11eb-37e6-67804e9df878
# ╠═127cfe26-3926-11eb-09be-5d022c22b8e7
# ╠═95e8f9a4-3926-11eb-1f22-4fcbabfb16ba
