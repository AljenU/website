---
title: How do I avoid having to allocate N copies of my data if I want to execute N jobs?
tags: [faq, peer]
---

# How do I avoid having to allocate N copies of my data if I want to execute N jobs?

When using [peercellfun](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peercellfun), you need to provide the arguments to your function as cell-arrays. Each cell-array should have one element per job that you want to execute. This can be problematic if you need to provide the same large array (e.g., electrophysiological data) as input to each of your jobs, since this can require impossible amounts of memory.

One way to take care of this is by using input- and outputfiles. See the FAQ on [faq:how_can_i_combine_fieldtrip_with_peer_distributed_computing](/faq/how_can_i_combine_fieldtrip_with_peer_distributed_computing) for this approach.

Another way to take care of this is by avoiding to use peercellfun, and instead relying on the lower-level [peerfeval](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peerfeval) and [peerget](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peerget). Peerfeval will submit a single job to an available peerworker, and return a job ID. Peerget should be provided with this job ID and will then retrieve the output of your job.

To use peerfeval and peerget properly, you will need to write some job-scheduling scaffolding code. Please refer to peercellfun's source code for an example of how to do this.
