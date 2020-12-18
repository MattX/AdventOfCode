### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 1725f4da-414d-11eb-0e0b-4d323e0476b1
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ b9ea048e-414f-11eb-39d5-afcd4788feaa
function part1(l)
	function pop_value(expr)
		last = popfirst!(expr)
		if last == '('
			return compute_line(expr)
		elseif last == ')'
			return nothing
		else
			return parse(Int, last)
		end
	end
	function compute_line(l)
		val = pop_value(l)
		if val == nothing
			throw("malformed expression")
		end
		while true
			if isempty(l)
				return val
			end
			op = popfirst!(l)
			if op == ')'
				return val
			end
			operand = pop_value(l)
			if op == '+'
				val += operand
			elseif op == '*'
				val *= operand
			end
		end
		return val
	end
	return compute_line([p[1] for p in split(l, "") if !isspace(p[1])])
end

# ╔═╡ 78c5bcd4-414d-11eb-06d9-fbacd871428e
sum(part1(l) for l in lines)

# ╔═╡ b84d5806-414f-11eb-0087-b1539dbae647
function part2(l)
	function pop_value(expr)
		last = popfirst!(expr)
		if last == '('
			return compute_line(expr)
		elseif last == ')'
			return nothing
		else
			return parse(Int, last)
		end
	end
	function compute_line(l)
		val_stack = [pop_value(l)]
		op_stack = []
		if val_stack[end] == nothing
			throw("malformed expression")
		end
		while true
			if isempty(l)
				return prod(val_stack)
			end
			op = popfirst!(l)
			if op == ')'
				return prod(val_stack)
			end
			operand = pop_value(l)
			if op == '+'
				val_stack[end] += operand
			elseif op == '*'
				push!(val_stack, operand)
			end
		end
		return prod(val_stack)
	end
	return compute_line([p[1] for p in split(l, "") if !isspace(p[1])])
end

# ╔═╡ 91712178-4153-11eb-2dae-39dc096a25ab
sum(part2(l) for l in lines)

# ╔═╡ 7e294608-414d-11eb-0c8d-7bd21ac9b2cd


# ╔═╡ Cell order:
# ╠═1725f4da-414d-11eb-0e0b-4d323e0476b1
# ╠═b9ea048e-414f-11eb-39d5-afcd4788feaa
# ╠═78c5bcd4-414d-11eb-06d9-fbacd871428e
# ╠═b84d5806-414f-11eb-0087-b1539dbae647
# ╠═91712178-4153-11eb-2dae-39dc096a25ab
# ╠═7e294608-414d-11eb-0c8d-7bd21ac9b2cd
