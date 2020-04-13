#!/usr/bin/env python3
""" creates an animated gif from a list of image files """
import argparse
from PIL import Image

parser = argparse.ArgumentParser(description='Create animated gifs')
parser.add_argument(
    '--duration',
    default=100,
    type=int,
    help='milliseconds to show each image'
)
parser.add_argument(
    '--loop',
    default=0,
    help='number of times the gif should loop; zero means forever'
)
parser.add_argument('outfile', help='name of animated gif file')
parser.add_argument('filenames', nargs='+', help='image files')

args = parser.parse_args()

# Create of list of Images from the filenames
images = [Image.open(filename) for filename in args.filenames]

# save group of images as animation
images[0].save(
    args.outfile,
    save_all=True,
    append_images=images[1:],
    duration=args.duration,
    loop=args.loop
)
