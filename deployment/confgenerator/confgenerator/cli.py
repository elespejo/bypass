
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
        info = args['conf-info']
        self.path = args['path']
        self._load_info(info)
        self.info_config = self.info_dict['config']
        self.info_white = self.info_dict['white']

    def _parse_arg(self):
        """Define the cli.
        Return: the parser of the cli.
        """
        parser = argparse.ArgumentParser(description='Generate bypass configuration.')
        parser.add_argument('conf-info')
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
        white_dir = self.path+'/bypass_conf'
        os.makedirs(white_dir)
        copy(PKG_DIR+'/bypass_confgenerator/01-inner', white_dir)
        copy(PKG_DIR+'/bypass_confgenerator/02-cn', white_dir)
        for file in self.info_white:
            f = open(white_dir+'/'+file['filename'], 'w')
            for content in file['content']:
                f.write(content+'\n')
            f.close

    def generate(self):
        """Generate the bypass configuration."""
        os.makedirs(self.path)
        self._gen_config()
        self._gen_white()


if __name__ == '__main__':
    CLI = bypass_confgen_cli(gen)
    CLI.generate()