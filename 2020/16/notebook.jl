### A Pluto.jl notebook ###
# v0.12.17

using Markdown
using InteractiveUtils

# ╔═╡ 993f87e4-3fae-11eb-1da4-f1d1cd427b3c
input = open("input.txt") do f 
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 5004286c-3fae-11eb-2755-29733cda9894
range_re = r"^(?P<field_name>[a-z ]+): (?P<r1start>[0-9]+)-(?P<r1end>[0-9]+) or (?P<r2start>[0-9]+)-(?P<r2end>[0-9]+)$"

# ╔═╡ 93d1c978-3fae-11eb-327a-c9c2c5f02daa
function get_info(input)
	ranges = []
	your_ticket = undef
	tickets = []
	phase = :ranges
	for line in input
		if phase == :ranges
			if line == "your ticket:"
				phase = :your_ticket
				continue
			end
			m = match(range_re, line)
			if m == nothing
				throw(line)
			end
			r1 = (parse(Int, m[:r1start]), parse(Int, m[:r1end]))
			r2 = (parse(Int, m[:r2start]), parse(Int, m[:r2end]))
			push!(ranges, (r1, r2))
		elseif phase == :your_ticket
			if line == "nearby tickets:"
				phase = :nearby_tickets
				continue
			end
			your_ticket = [parse(Int, x) for x in split(line, ",")]
		elseif phase == :nearby_tickets
			push!(tickets, [parse(Int, x) for x in split(line, ",")])
		else
			throw(phase)
		end
	end
	return (ranges, your_ticket, tickets)
end

# ╔═╡ cf53be24-3faf-11eb-02b0-396943be753a
function field_valid(ranges, value)
	for ((r1s, r1e), (r2s, r2e)) in ranges
		if r1s <= value <= r1e || r2s <= value <= r2e
			return true
		end
	end
	return false
end

# ╔═╡ 043e2584-3fb0-11eb-106c-997d91085e6c
function part1(input)
	(ranges, your_ticket, tickets) = get_info(input)
	error_value = 0
	for ticket in tickets
		for value in ticket
			if !field_valid(ranges, value)
				error_value += value
			end
		end
	end
	return error_value
end

# ╔═╡ 27c75160-3fb0-11eb-3196-8d33a6129df7
part1(input)

# ╔═╡ ca5ad140-3fb0-11eb-1eb1-c71f6dd53287
function range_valid(field_range, value)
	(r1s, r1e), (r2s, r2e) = field_range
	return r1s <= value <= r1e || r2s <= value <= r2e
end

# ╔═╡ c1fa9fe6-3fb1-11eb-01cc-3938845f01b6
function find_idx(iter, value)
	for (i, v) in enumerate(iter)
		if v == value
			return i
		end
	end
end

# ╔═╡ 52e2ed44-3fb0-11eb-0a69-e7c0e6db5f27
# ok just to be clear: validity[x, y] = true if the xth field in tickets can
# map to the yth field defined at the top of the doc
function validity_matrix(input)
	(ranges, your_ticket, tickets) = get_info(input)
	num_fields = length(your_ticket)
	valid_tickets = [t for t in tickets if all(field_valid(ranges, v) for v in t)]
	validity = ones(Bool, num_fields, num_fields)
	for t in valid_tickets
		for (i_v, v) in enumerate(t)
			for (i_f, field) in enumerate(ranges)
				if !range_valid(field, v)
					validity[i_v, i_f] = false
				end
			end
		end
	end
	return validity
end

# ╔═╡ 7107d3c0-3fb0-11eb-11ef-2beee02c6157
function part2(input)
	(ranges, your_ticket, tickets) = get_info(input)
	validity = validity_matrix(input)
	# n_field = in tickets, dests = at the top of the doc
	function check_perm(n_field, remaining_dests)
		if n_field == 21
			return Dict()
		end
		for dest in remaining_dests
			if !validity[n_field, dest]
				continue
			end
			sub_asst = check_perm(n_field + 1, setdiff(remaining_dests, [dest]))
			if sub_asst != nothing
				sub_asst[n_field] = dest
				return sub_asst
			end
		end
	end
	assts = check_perm(1, Set(1:20))
	field_idx = collect(keys(filter(x -> x[2] in 1:6, assts)))
	return prod(map(x -> your_ticket[x], field_idx))
end

# ╔═╡ 2c7fddf0-3fc2-11eb-3dbf-d70aeec54b8c
part2(input)

# ╔═╡ Cell order:
# ╠═993f87e4-3fae-11eb-1da4-f1d1cd427b3c
# ╠═5004286c-3fae-11eb-2755-29733cda9894
# ╠═93d1c978-3fae-11eb-327a-c9c2c5f02daa
# ╠═cf53be24-3faf-11eb-02b0-396943be753a
# ╠═043e2584-3fb0-11eb-106c-997d91085e6c
# ╠═27c75160-3fb0-11eb-3196-8d33a6129df7
# ╠═ca5ad140-3fb0-11eb-1eb1-c71f6dd53287
# ╠═c1fa9fe6-3fb1-11eb-01cc-3938845f01b6
# ╠═52e2ed44-3fb0-11eb-0a69-e7c0e6db5f27
# ╠═7107d3c0-3fb0-11eb-11ef-2beee02c6157
# ╠═2c7fddf0-3fc2-11eb-3dbf-d70aeec54b8c
