# Work flow
### Download the project
```bash
git clone https://github.com/elespejo/bypass.git
cd bypass/
```

### Build docker image 
After modifying the Dockerfile, use the command below to build the docker  image:
```bash
make mk-image ARCH=[arch]
```
The `arch` can be `x86` or `armv6`.
This action build a docker image named `elespejo/bypass-[arch]:latest` by using the resource in directory `image`.

### Clean docker image 
```bash
make clean-image ARCH=[arch]
```

### Build bypass client x86 image API
```bash
make mk-deployment-x86 VERSION=[version]
```

### Build bypass client armv6 image API
```bash
make mk-deployment-armv6 VERSION=[version]
```

### Build configuration generator
```bash
make mk-confgenerator VERSION=[version]
```

### Build all package
```bash
make mk-deployment VERSION=[version]
```

### Build gitbook
```bash
make mk-book
```