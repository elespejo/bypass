
import os
import yaml
from shutil import copy
import argparse
import confgenerator.generator as gen

# sys.tracebacklimit = 0 # no traceback
PKG_DIR = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))

class bypass_confgen_cli():
    """The CLI of the bypass configuration generator."""
    def __init__(self, generator):
        """
        Argument:
            generator : the generator object.
        """
        self.gen = generator
        self._parse_arg()
        args = vars(self.parser.parse_args())
        info = args['info']
        self.path = args['path']
        self._load_info(info)
        self.info_config = self.info_dict['config']
        self.info_vps = self.info_dict['bypass-vps']
        self.info_dir = self.info_dict['whitelist-dir']

    def _parse_arg(self):
        """Define the cli.
        Return: the parser of the cli.
        """
        parser = argparse.ArgumentParser(description='Generate bypass configuration.')
        parser.add_argument('-f', dest='info')
        parser.add_argument('-d', '--destination', dest='path', default=PKG_DIR+'/bypass')

        self.parser = parser

    def _load_info(self, file):
        """Transfer yaml file to dict."""
        info_dict = yaml.load(open(file, 'r'))
        self.info_dict = info_dict

    def _gen_config(self):
        """Generate config env file."""
        lan = self.info_config['lan']
        base_port = self.info_config['base_port']
        number = self.info_config['number']
        self.gen.Gen_config(lan, base_port, number, self.path).write()

    def _gen_white(self):
        """Generate white list."""
        white_dir = self.path+'/conf'
        os.makedirs(white_dir)
        copy(PKG_DIR+'/confgenerator/01-inner', white_dir)
        copy(PKG_DIR+'/confgenerator/02-cn', white_dir)
        
        # generate vps
        f = open(white_dir+'/vps', 'w')
        for content in self.info_vps:
            f.write(content+'\n')
        f.close

        # copy file in white list directory
        files = os.listdir(self.info_dir)
        for file in files:
            full_file_name = os.path.join(self.info_dir, file)
            if (os.path.isfile(full_file_name)):
                copy(full_file_name, white_dir)

    def generate(self):
        """Generate the bypass configuration."""
        os.makedirs(self.path)
        self._gen_config()
        self._gen_white()


if __name__ == '__main__':
    CLI = bypass_confgen_cli(gen)
    CLI.generate()
