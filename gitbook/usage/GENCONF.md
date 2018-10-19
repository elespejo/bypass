# Generate configuration

### Download the configuration generator
You can download the generator package from web page or command line.

* From web:  
    Go to the [release page](https://github.com/elespejo/bypass/releases) of this project and download `bypass-confgenerator-[VERSION].zip`.

* From command line:  
    ```bash
    wget https://github.com/elespejo/bypass/releases/download/[VERSION]/bypass-confgenerator-[VERSION].zip
    ```
    e.g, download configuration generator of version 0.3.7
    ```bash
    wget https://github.com/elespejo/bypass/releases/download/0.3.7/bypass-confgenerator-0.3.7.zip
    ```

### Unzip
```bash
unzip bypass-confgenerator-[VERSION].zip
```
e.g,
```bash
unzip bypass-confgenerator-0.3.7.zip
```

### Generate configuration

```bash
cd confgenerator
./gen-vps.sh [NAME] [IP]...
```
in which,
* [NAME]: The file name
* [IP]: The ips that add to the file  

e.g, generate bypass configuration
```bash
./gen-vps.sh 02-vps 123.45.67.89/32 
``` 

You can validate the result by `cat 02-vps`, with successful output similar with the following,
```
123.45.67.89/32
```
