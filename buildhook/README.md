A simple reverse shell from inside a build hook as used by Docker Cloud/Hub. Change evil.host:5000 to your desired reverse shell catching host.

Your actual repo will probably need a Dockerfile (I don't know if docker hub will let you get away with not having one), hence the "docker build" line in there.
