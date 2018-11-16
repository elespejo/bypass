class Gen_config():
    """Generate bypass config file."""
    def __init__(self, lan, base_port, number, path):
        """
        Argument:
            lan : the lan interface of machine.
            base_port : start port for bypass redirection.
            number : the number of redirect port.
            path : the location of generated file.
        """
        self.lan = lan
        self.base_port = base_port
        self.number = number
        self.path = path

    def write(self):
        """Write env config to file."""
        f = open(self.path+'/bypass-config.env', 'w')
        f.write("LAN=%s\n" % self.lan)
        f.write("BASE_PORT=%s\n" % self.base_port)
        f.write("BALANCE_NUM=%s\n" % self.number)
        f.close

class Gen_white():
    """Generate bypass white list."""
    def __init__(self, filename, content, path):
        """
        Argument:
            filename : the filename of the white list.
            content : the content of the file.
            path : the location of generated file.
        """
        self.filename = filename
        self.content = content
        self.path = path

    def write(self):
        """Generate the bypass white file."""
        f = open(self.path+"/"+self.filename, "w")
        for line in self.content:
            f.write(line+'\n')
        f.close