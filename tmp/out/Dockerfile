# parent image
FROM golang:1.15.6-alpine3.12

# workspace directory
WORKDIR /app

# copy `go.mod` and `go.sum`
ADD go.mod go.sum ./

# install dependencies: download modules to local cache
RUN go mod download

# copy the source code 
# from the build context 
# to the /app directory of the image
COPY . .

# build executable
# Create avatar executable file inside /app/bin directory of the image.
RUN go build -o ./bin/avatar .

# create volume
VOLUME [ "/app/shared" ]

# set entrypoint
# The ENTRYPOINT instruction 
# sets the default command for the container
# when the docker command -- $ run <image> -- 
# is run.
# 
# ENTRYPOINT ["executable", "param1", "param2"] < exec  - form
# ENTRYPOINT command param1 param2              < shell - form: executes the command using /bin/sh -c
# 
ENTRYPOINT [ "./bin/avatar" ]

# set default arguments
# 
# The CMD instruction, 
# if ENTRYPOINT is present in the Dockerfile, 
# will act as default arguments 
# for the command represented by the ENTRYPOINT. 
# Therefore, the final ENTRYPOINT command 
# in the setting above would be :
# 
# -- $ executable param1 param2 param3 param4 --
# 
# But, these parameters can be overwrittem 
# by providing arguments in the docker command
# 
# -- $ run <image> param33 param44 --
# 
# CMD [ "param3", "param4" ]
# 
CMD [ "./test.jpg", "./shared/test_out.jpg" ]
