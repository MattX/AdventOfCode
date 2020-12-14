### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 4efa377a-3db7-11eb-22a1-2103d7882503
array = open("input.txt") do f
	permutedims(hcat([[c for c in l] for l in readlines(f) if !isempty(l)]...))
end

# ╔═╡ 780530de-3db7-11eb-3ca9-31b78f8c9e61
function neighbors(x, y, dims)
	(x_max, y_max) = dims
	neighbors = []
	for i in max(1, x-1):min(x_max, x+1)
		for j in max(1, y-1):min(y_max, y+1)
			if i != x || j != y
				push!(neighbors, (i, j))
			end
		end
	end
	return neighbors
end

# ╔═╡ 3c1983ee-3db8-11eb-2d85-c12475cedcf2
function evol(seats, view_counter, max_occupancy)
	dims = size(seats)
	new_seats = fill('x', dims)
	for (x, y) in ((x, y) for x in 1:dims[1], y in 1:dims[2])
		if seats[x, y] == '.'
			new_seats[x, y] = '.'
			continue
		end
		live_count = view_counter(seats, x, y, dims)
		if seats[x, y] == 'L' && live_count == 0
			new_seats[x, y] = '#'
		elseif seats[x, y] == '#'  && live_count >= max_occupancy
			new_seats[x, y] = 'L'
		else
			new_seats[x, y] = seats[x, y]
		end
	end
	return new_seats
end

# ╔═╡ ec89fe3c-3db8-11eb-0190-93362cde51a8
function part1(array)
	function view_counter(arr, x, y, dims)
		return sum(arr[c...] == '#' for c in neighbors(x, y, dims))
	end
	while true
		old_array = array
		array = evol(array, view_counter, 4)
		if array == old_array
			break
		end
	end
	return sum(a == '#' for a in array)
end

# ╔═╡ 8636a1c6-3dba-11eb-2043-a7f96df441c8
part1(array)

# ╔═╡ 8d9d545e-3e15-11eb-13af-df43a4e7c249
function valid(x, y, dims)
	return 1 <= x <= dims[1] && 1 <= y <= dims[2]
end

# ╔═╡ dc3637ca-3e15-11eb-0da1-f74e2848a04d
function check_line(arr, x_start, y_start, x_direction, y_direction)
	dims = size(arr)
	for d in Iterators.countfrom(1)
		(xp, yp) = [x_start, y_start] + [x_direction, y_direction] * d
		if !valid(xp, yp, dims)
			return false
		elseif arr[xp, yp] == 'L'
			return false
		elseif arr[xp, yp] == '#'
			return true
		end
	end
end

# ╔═╡ da3bfc6a-3dbf-11eb-2952-17b5c09fc551
function view_counter2(arr, x, y, dims)
	total = 0
	for xn in -1:1
		for yn in -1:1
			if xn != 0 || yn != 0
				total += check_line(arr, x, y, xn, yn)
			end
		end
	end
	return total
end

# ╔═╡ 4fb447aa-3e16-11eb-0076-79f2659c4ff3
function part2(array)
	while true
		old_array = array
		array = evol(array, view_counter2, 5)
		if array == old_array
			break
		end
	end
	return sum(a == '#' for a in array)
end

# ╔═╡ 90354156-3dbe-11eb-1138-d55504572d63
part2(array)

# ╔═╡ Cell order:
# ╠═4efa377a-3db7-11eb-22a1-2103d7882503
# ╠═780530de-3db7-11eb-3ca9-31b78f8c9e61
# ╠═3c1983ee-3db8-11eb-2d85-c12475cedcf2
# ╠═ec89fe3c-3db8-11eb-0190-93362cde51a8
# ╠═8636a1c6-3dba-11eb-2043-a7f96df441c8
# ╠═8d9d545e-3e15-11eb-13af-df43a4e7c249
# ╠═dc3637ca-3e15-11eb-0da1-f74e2848a04d
# ╠═da3bfc6a-3dbf-11eb-2952-17b5c09fc551
# ╠═4fb447aa-3e16-11eb-0076-79f2659c4ff3
# ╠═90354156-3dbe-11eb-1138-d55504572d63
