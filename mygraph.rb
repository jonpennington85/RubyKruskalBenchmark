#!/usr/bin/env ruby

# Author: Jonathan Pennington
# CS-4310: Design and Analysis of Algorithms
# Date: 4/21/17
# Assignment 7: Graph

require_relative 'myedge'
require_relative 'myvertex'

class MyGraph
	# Should include attributes of an array of MyEdge and an array of MyVertex
	attr_accessor :Edges, :Vertices, :Hash

	def initialize
		@Edges=[]
		@Vertices=[]
		@Hash=Hash.new
	end

	# Returns a new vertex object
	def new_vertex(label)
		tmp=MyVertex.new
		tmp.label=label

		# We should add some descriptive hash here
		@Hash[label] = @Vertices.length
		return tmp
	end

	# Returns a new edge object
	def new_edge(label,points)
		tmp=MyEdge.new
		tmp.label=label
		
		# Points should be two strings, not the Vertex objects themselves
		tmp.points=points
		return tmp
	end


	# Removes edge and deletes any references a Vertex has to it
	def remove_edge(e)
		# Delete an edge
		for i in 0..num_edges-1
			if @Edges[i].points[0] == e.points[0] and @Edges[i].points[1] == e.points[1]
				@Edges.delete_at(i)
				break
			elsif @Edges[i].points[1] == e.points[0] and @Edges[i].points[0] == e.points[1]
				@Edges.delete_at(i)
				break
			end
		end
#		rehash
	end

	# Removes vertex and any edges that connect to it
	def remove_vertex(v)
		@Vertices.delete_at(@Hash[v.label])
		num=num_edges-1
		i=0
		while i != num do
			if @Edges[i].points[0] == v.label or @Edges[i].points[1] == v.label
				@Edges.delete_at(i)
				i=-1
				num=num-1
			end
			i+=1
		end
		rehash
	end

	# Reforms Hash
	def rehash
		@Hash=Hash.new
		for i in 0..num_vertices-1
			@Hash[@Vertices[i].label]=@Vertices[i]
		end
	end

	# Returns the number of vertices
	def num_vertices
		return @Vertices.length
	end

	# Returns the number of edges
	def num_edges
		return @Edges.length
	end

	# Returns an array of all vertices
	def list_vertices
		return @Vertices
	end

	# Returns an array of all edges
	def list_edges
		return @Edges
	end

	# Returns the given vertex v
	# This method seems pointless, but is in specs
	def vertex(v)
		if v==0
			return @Vertices[0]
		end

		return @Vertices[@Hash[v]]
	end

	# Returns the degree of the given vertex v
	def deg_vertex v

		deg=0

		# Store vertex v as temp variable
		tmp = v

		# For all Edges, check their points to see if v.label is in them. If it is, increment
		for i in 0..@Edges.length-1
			if @Edges[i].points[0] == v.label
				deg+=1
			end
			if @Edges[i].points[1] == v.label
				deg+=1
			end
		end

		# Return number of degrees
		return deg
	end

	# Return array of connecting edges of vertex v
	def incident_edges v
		temp_array = []
		for i in 0..num_edges-1
			if @Edges[i].points[0] == v.label
				temp_array << @Edges[i]
			elsif @Edges[i].points[1] == v.label
				temp_array << @Edges[i]
			end
		end
		return temp_array
	end

	# Return array of adjacent vertices of vertex v (those it is connected to through an edge)
	def adjacent_vertices v
		temp_array = []
		for i in 0..num_edges-1
			if @Edges[i].points[0] == v.label
				temp_array << @Vertices[@Hash[@Edges[i].points[1]]]
			end
			if @Edges[i].points[1] == v.label
				temp_array << @Vertices[@Hash[@Edges[i].points[0]]]
			end
		end

		return temp_array

	end

	# Returns the two ends of a given edge e
	def end_vertices(e)
		temp_array = []
		for i in 0..num_edges-1
			if @Edges[i].label==e.label
				tmp2 = @Edges[i].points
			end
		end
		temp_array << @Vertices[@Hash[tmp2[0]]]
		temp_array << @Vertices[@Hash[tmp2[1]]]
		return temp_array
	end

	# Return a true or false to tell whether or not vertices v and w are adjacent
	def are_adjacent(point_a,point_b)
		for i in 0..num_edges-1
			if @Edges[i].points[0] == point_a.label && @Edges[i].points[1] == point_b.label
				return true
			elsif @Edges[i].points[1] == point_a.label && @Edges[i].points[0] == point_b.label
				return true
			end
		end
		return false
	end

	# Return true if the given Vertex is in the Graph
	def exists v
		for i in 0..num_edges
			if v.label==@Vertices[i].label
				return true
			end
		end
		return false
	end

end



























