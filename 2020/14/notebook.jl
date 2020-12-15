### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ e08ade12-3e48-11eb-0fd4-7123aae91023
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 194e71da-3e49-11eb-0577-d561679028ec
function mask_to_bitmasks(mask)
	and_mask = parse(Int, replace(mask, "X" => "1"); base=2)
	or_mask = parse(Int, replace(mask, "X" => "0"); base=2)
	return (and_mask, or_mask)
end

# ╔═╡ 813c5e9c-3e49-11eb-0121-279c023862fc
mask_re = r"^mask = (?P<mask>[X01]{36}$)"

# ╔═╡ 901b5ae4-3e49-11eb-1bd0-2371224f0e43
mem_re = r"^mem\[(?P<addr>[0-9]+)] = (?P<val>[0-9]+)$"

# ╔═╡ ef919014-3e4a-11eb-1b44-318b83c49e70
function resize_zeros(arr, new_len)
	additional_length = max(0, new_len - length(arr))
	return append!(arr, zeros(Int, additional_length))
end

# ╔═╡ 7b3624e2-3e49-11eb-104e-439ee60ccd28
function part1(lines)
	and_mask = undef
	or_mask = undef
	mem = []
	for line in lines
		mask_match = match(mask_re, line)
		if mask_match != nothing
			(and_mask, or_mask) = mask_to_bitmasks(mask_match[:mask])
		end
		mem_match = match(mem_re, line)
		if mem_match != nothing
			addr = parse(Int, mem_match[:addr])
			val = parse(Int, mem_match[:val])
			mem = resize_zeros(mem, addr)
			mem[addr] = (val & and_mask) | or_mask
		end
	end
	return sum(mem)
end

# ╔═╡ 76802ca8-3e4a-11eb-270f-7f698e946f29
part1(lines)

# ╔═╡ 38aa76d6-3f26-11eb-2979-1b8d4b8f6875
function addr_helper(addr, mask)
	if addr == []
		return [[]]
	end
	addr_fst, mask_fst = first(addr), first(mask)
	addr, mask = addr[2:end], mask[2:end]
	final = Vector{Char}[]
	sub_addr = addr_helper(addr, mask)
	if mask_fst == 'X' || (mask_fst == '0' && addr_fst == '0')
		append!(final, [vcat(['0'], x) for x in sub_addr])
	end
	if mask_fst == 'X' || !(mask_fst == '0' && addr_fst == '0')
		append!(final, [vcat(['1'], x) for x in sub_addr])
	end
	return final
end

# ╔═╡ f868e184-3f25-11eb-399b-170194d731da
function addrs(addr, mask)
	addr, mask = collect(addr), collect(mask)
	return [parse(Int, String(x); base=2) for x in addr_helper(addr, mask)]
end

# ╔═╡ c9370fea-3f29-11eb-3983-b53b8623ab39
import Printf

# ╔═╡ 952772f0-3f27-11eb-1421-534ef957fa93
function num_to_bin(n)
	return lpad(string(n; base=2), 36, '0')
end

# ╔═╡ 94e6dd76-3f27-11eb-1e61-5fcdfc39836a
function part2(lines)
	mask = undef
	mem = Dict()
	for line in lines
		mask_match = match(mask_re, line)
		if mask_match != nothing
			mask = mask_match[:mask]
		end
		mem_match = match(mem_re, line)
		if mem_match != nothing
			addr = parse(Int, mem_match[:addr])
			val = parse(Int, mem_match[:val])
			for addr in addrs(num_to_bin(addr), mask)
				mem[addr] = val
			end
		end
	end
	return sum(values(mem))
end

# ╔═╡ 501dc90e-3f2a-11eb-07de-43c3fb9b19e9
part2(lines)

# ╔═╡ Cell order:
# ╠═e08ade12-3e48-11eb-0fd4-7123aae91023
# ╠═194e71da-3e49-11eb-0577-d561679028ec
# ╠═813c5e9c-3e49-11eb-0121-279c023862fc
# ╠═901b5ae4-3e49-11eb-1bd0-2371224f0e43
# ╠═ef919014-3e4a-11eb-1b44-318b83c49e70
# ╠═7b3624e2-3e49-11eb-104e-439ee60ccd28
# ╠═76802ca8-3e4a-11eb-270f-7f698e946f29
# ╠═38aa76d6-3f26-11eb-2979-1b8d4b8f6875
# ╠═f868e184-3f25-11eb-399b-170194d731da
# ╠═c9370fea-3f29-11eb-3983-b53b8623ab39
# ╠═952772f0-3f27-11eb-1421-534ef957fa93
# ╠═94e6dd76-3f27-11eb-1e61-5fcdfc39836a
# ╠═501dc90e-3f2a-11eb-07de-43c3fb9b19e9
