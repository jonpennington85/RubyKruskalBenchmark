#!/usr/bin/env ruby

# Author: Jonathan Pennington
# CS-4310: Design and Analysis of Algorithms
# Date: 4/21/17
# Assignment 7: Kruskal

# Note: Requires pqueue gem to be installed with 'gem install pqueue'

require_relative "mygraph"
require_relative "myvertex"
require_relative "myedge"
require "benchmark"
require 'pqueue'


def KruskalGraph(g)

	cluster=Array.new

	# Create cluster for each vertex
	for i in 0..g.Vertices.length-1
		cluster[i]=MyGraph.new
		cluster[i].Vertices << g.Vertices[i]

	end

	# Create Priority Queue for Edges in g
	pq=PQueue.new(g.Edges) { |a,b| a.label < b.label }

	kruskal=MyGraph.new
	verts=Array.new

	# While our kruskal graph has less than numVertices-1
	while kruskal.num_edges < g.num_vertices-1 do

		tempEdge=pq.pop

		if pq.length==0
			break
		end

		verts[0] = g.vertex(tempEdge.points[0])
		verts[1] = g.vertex(tempEdge.points[1])

		# Find the cluster containing verts of edge
		for i in 0..cluster.length-1
			if cluster[i].exists(verts[0])
				tempCluster1 = cluster[i]
				numCluster1=i
			end
		end

		for i in 0..cluster.length-1
			if cluster[i].exists(verts[1])
				tempCluster2 = cluster[i]
				numCluster2=i
			end
		end

		# If Vertex tempEdge.points[0] and tempEdge.points[1] do not exist in the same cluster
		if tempCluster1!=tempCluster2
			# Add tempEdge to kruskal graph
			kruskal.Edges << tempEdge
			
			# Merge cluster 1 and cluster2 into one cluster
			
			for i in 0..tempCluster1.num_vertices-1
				tempCluster2.Vertices << tempCluster1.Vertices[i]
			end

			# Add cluster to cluster array
			
			cluster << tempCluster2

			# Delete original clusters
			cluster.delete_at(numCluster1)
			cluster.delete_at(numCluster2)
		end

		
	end

	return kruskal
end
