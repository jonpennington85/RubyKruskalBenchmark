#!/usr/bin/env ruby

# Author: Jonathan Pennington
# CS-4310: Design and Analysis of Algorithms
# Date: 4/21/17
# Assignment 7: Kruskal

# Note: Requires pqueue gem to be installed with 'gem install pqueue'

require_relative "kruskal"

# Create Graph Object
graph=MyGraph.new

# Create a File for the data to go into

dataFile=open('data.csv','w')

# Now we create a bunch of Vertices and Edges

k=0

# This is the number of benchmarks we will perform
for i in 1..500

	# Create the first Vertex, as this is kind of a special case since it can't have edges yet
	graph.Vertices << graph.new_vertex(0)

	# This will increment and perform one larger benchmark each time
	for j in 1..i+1
		
		# Create number of vertices
		graph.Vertices << graph.new_vertex(j)
		
		# Create number of edges = vertices-1 (Guarantees graph will be connected)
		graph.Edges << graph.new_edge(rand(2000)+1,[j,j-1])

		# Now we pick a random element from the graph		
		k=rand(j)
		
		# Do While loops don't exist because ruby is retarded
		l=k
		while l==k do
			if k==0
				break
			end
			l=rand(j)
		end

		# If this edge doesn't already exist, add it
		if !graph.are_adjacent(graph.Vertices[k],graph.Vertices[l]) && !graph.are_adjacent(graph.Vertices[l],graph.Vertices[k]) && k!=0
			graph.Edges << graph.new_edge(rand(2000)+1,[k,l])
		end

	end

		# Benchmark Kruskal algorithm
		time = Benchmark.measure do |i|
			10.times do
				KruskalGraph(graph)
			end
		end

		puts i
		puts time
		
		dataFile.write("#{i},#{time.real/10}\n");

	graph=MyGraph.new
end
