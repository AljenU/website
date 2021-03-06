---
title: How can I set up the peer distributed computing on a small number of computers?
tags: [faq, peer]
---

# How can I set up the peer distributed computing on a small number of computers?

It is common for researchers to share their office with multiple people, each one with a workstation computer under their desk. In the evening, when everyone has gone home, those computers just stand around, unused. The peer distributed computing toolbox allows you to easily make use of them!

In the evening, when your colleagues are gone, you log in on their computer. Subsequently you start MATLAB and start **[peerworker](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peerworker.m)** on the MATLAB command line. For a computer with a multicore CPU the best is to start multiple MATLAB sessions as peerworker, one per CPU core.

After starting the workers on your colleagues computer, you go to your own computer, start a MATLAB session and type **[peerlist](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peerlist.m)**.

This should show you the idle workers on your colleagues' computers other computers. Subsequently you can get started with **[peercellfun](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peercellfun.m)**.

Instead of using only peerworkers on your colleagues' computers, you should also start a few peerworkers on your own computer. The controller will not be really busy, it just hands out the jobs and collects the results. To use the CPU in your own computer efficiently, you should have N+1 MATLAB sessions running on your computer, one for the controller and N for the workers (where N is the number of CPU cores). This should result in 100% CPU usage on your computer.

Please note that [firewall settings](/faq/does_a_firewall_affect_the_communication_between_peers) can affect the peer network.

## Access control

To ensure that the workers that you have started cannot be accessed by another user on the same network, you can do

    peerworker('allowuser', `<yourusername>`)

If you explicitly want to share the computers with multiple people, you can do

    peerworker('allowuser', {`<username1>`, `<username2>`, ...})

If you want to control the computers to which the controller submits the jobs, you can use the allowuser or allowhost options in **[peercontroller](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peercontroller.m)**, i.e.

    peercontroller('allowuser', `<yourusername>`)
    peercellfun(@funname, {...})

will only execute the jobs on your own workers.

## The next morning...

In the morning, your colleagues might arrive earlier to their desk than you, and of course then they want their computer back. If the workers are idle, they can simply exit the MATLAB sessions you started and regain control. If the workers are still busy executing their job, they can simply kick you out (e.g. reboot, or ctrl-c your MATLAB workers). The **[peercellfun](https://github.com/fieldtrip/fieldtrip/blob/release/peer/peercellfun.m)** will automatically resubmit the jobs that fail, i.e. if one of the workers disappears, the job that it was running will be resubmitted elsewhere.

That is why you want also to have a few workers running on your own computer: these will take over the remaining jobs, once all your colleagues' computers are confiscated again by their respective owners.
