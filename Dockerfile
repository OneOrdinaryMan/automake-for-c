# Make the program
FROM gcc:latest as maker
ADD hello-0.0.1.tar.gz /usr/src/myapp
WORKDIR /usr/src/myapp/hello-0.0.1
RUN ["/bin/bash", "-c", "./configure"]
RUN ["/bin/bash", "-c", "make"]
# Run the hello program
FROM maker as runner
CMD ["/bin/bash", "-c", "./src/hello"]
# Install the program
FROM maker as installer
RUN ["/bin/bash", "-c", "make install"]
# Check the program in path
FROM installer as check-install
WORKDIR /
RUN ["/bin/bash", "-c", "apt update && apt install which"]
CMD ["/bin/bash", "-c", "hello && which hello"]
FROM installer as uninstaller
CMD ["/bin/bash", "-c", "make uninstall"]
