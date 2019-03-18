#!/usr/bin/env python3

from math import sin, cos, pi, radians
from tkinter import Canvas

# Types:
class GeoType(Enum):
    LINE   = 1
    ARC    = 2
    CIRCLE = 3

class Drawable(object):
    def draw(self, canvas: Canvas):
        pass

class Geo(object, Drawable):
    """A Geometric Primitive. For example, a line."""

class Line(Geo):

    def __init__(self, )


polar = lambda rad, ang: (cos(radians(ang)) * rad, sin(radians(ang)) * rad)

def channel(angle, width, outer_rad, inner_rad, bands):
    # <= 4mm on the outer ring:
    sep_angle = (3.5 / (outer_rad)) / 2

    # 5 to 1 ratio for starting tendril width to ending tendril width:
    # We'll have `bands` tendrils, each separated by the ending tendril width (so
    # that tendrils can be interlaced). This means `bands` * (starting tendril
    # width + ending tendril width) = (outer_rad - inner_rad).
    band_width = (outer_rad - inner_rad) / bands
    tendril_starting = (5 / 6) * band_width
    tendril_ending   = (1 / 6) * band_width
    tendril_length = width - sep_angle

    if tendril_starting > 4:
        print("Add more bands!!")

    # First left (halved):
    yield []

    for i in range(bands):
        # Left (CCW):
        



        # Right (CW):

    print(tendril_starting, tendril_ending)


# Assumes 3 channels and outer_rad/inner_rad in mm
def wheel_coords(outer_rad, inner_rad, bands):
    sep_angle = (3.5 / (outer_rad))

    # 5 to 1 ratio for starting tendril width to ending tendril width:

    outer_circle = (-outer_rad, -outer_rad, outer_rad, outer_rad)
    inner_circle = (-inner_rad, -inner_rad, inner_rad, inner_rad)

    ch = lambda angle: channel(radians(angle), radians(240), outer_rad, inner_rad, bands)

    return ([ inner_circle, outer_circle ], ch(0), ch(120), ch(240))


OUTER_RAD = 50
INNER_RAD = 15
BANDS = 8

SCALE = 7

def sc(*args):
    return [ SCALE * i for i in args]

def draw_wheel(canvas):
    coords = wheel_coords(OUTER_RAD, INNER_RAD, BANDS)

    base = coords[0]

    canvas.create_oval(*sc(*base[0]), fill = "grey")
    canvas.create_oval(*sc(*base[1]), outline = "red")

def printcoords(event):
    (x, y) = (event.x, event.y)
    print (x // SCALE, y // SCALE)

if __name__ == "__main__":
    root = Tk()

    #setting up a tkinter canvas with scrollbars
    frame = Frame(root, bd=2, relief=SUNKEN)
    frame.grid_rowconfigure(0, weight=1)
    frame.grid_columnconfigure(0, weight=1)
    xscroll = Scrollbar(frame, orient=HORIZONTAL)
    xscroll.grid(row=1, column=0, sticky=E+W)
    yscroll = Scrollbar(frame)
    yscroll.grid(row=0, column=1, sticky=N+S)
    canvas = Canvas(frame, bd=0, xscrollcommand=xscroll.set, yscrollcommand=yscroll.set)
    canvas.grid(row=0, column=0, sticky=N+S+E+W)
    xscroll.config(command=canvas.xview)
    yscroll.config(command=canvas.yview)
    frame.pack(fill=BOTH,expand=1)

    canvas.create_image(0,0,anchor="nw")

    draw_wheel(canvas)

    canvas.config(scrollregion=canvas.bbox(ALL))
    canvas.bind("<Button 1>", printcoords)

    root.mainloop()
