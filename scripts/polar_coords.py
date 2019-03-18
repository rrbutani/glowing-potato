#!/usr/bin/env python3.7

from math import sin, cos, pi, radians
from tkinter import Canvas
from typing import Iterable, List, Tuple

# Types:
class Drawable(object):
    def draw(self, canvas: Canvas):
        pass

class AsEagle(object):
    def as_eagle(self, name: str) -> str:
        pass

Point = Tuple[float, float]

class AsPoints(object):
    @staticmethod
    def repeat(num: int, *points: Point) -> Iterable[float]:
        for p in points:
            for n in range(num):
                yield p[0]
                yield p[1]

    @staticmethod
    def format_point(point: Point) -> str:
        return f"({point[0]} {point[1]})"

    p = lambda point: format_point(p)

    def as_points(self) -> Iterable[float]:
        pass

class Geo(object, AsPoints, AsEagle):
    """A Geometric Primitive. For example, a line."""

class Polygon(object, AsEagle, Drawable):
    """A bundle of geometric primitives."""

    name: str = ""
    geos: List[Geo] = []

    def __init__(self, name: str, *geos: Geo):
        name = name
        points = list(geos)

    def draw(self, canvas: Canvas):
        canvas.create_polygon(
            [point for geo in geos for point in geo.as_points()],
            fill = "red",
            outline = "grey",
            width = 2
        )

    def as_eagle(self, name: str) -> str:
        first = geos[0].as_points()
        first = (next(first), next(first))

        out = '\n'.join(cmd for geo in geos for cmd in geo.as_eagle(name))

        return out + f"\npolygonize '{name}' {p(first)};\n"

    def as_list(self) -> List[Geo]:
        return geos

    def add_geos(self, *geos: Geos):
        self.geos += geos

class Line(Geo):
    p1: Point, p2: Point = (0, 0), (0, 0)

    def __init__(self, x1, y1, x2, y2):
        p1, p2 = (x1, y1), (x2, y2)

    def as_points(self) -> Iterable[float]:
        return self.repeat(2, p1, p2)

    def as_eagle(self, name: str) -> str:
        return f"line '{name}' {p(p1)} {p(p2)};"

class Arc(Geo):
    """Represents an arc as a center, a radius, and starting/ending angles.

    Note: the Arc represented will go clockwise from the starting angle to the
    ending angle. 0 degrees is on the positive side of the x axis.
    """

    center: Point, radius: int, starting: float, ending: float = (0, 0), 0, 0, 0

    def __init__(self, x: float, y: float, rad: float, starting: float,
            ending: float):
        center, radius = (x, y), rad
        self.starting, self.ending = starting % 360, ending % 360

    @classmethod
    def from_polar(cls, center: Point, radius: float, starting_angle: float,
            ending_angle: float):
        return cls(*center, radius, starting_angle, ending_angle)

    @classmethod
    def from_points(cls, )

    p2c = lambda rad, ang: (cos(radians(ang)) * rad, sin(radians(ang)) * rad)

    def as_points(self) -> Iterable[float]:
        return self.repeat(1, p1, p2)

    def to_eagle(self, name: str) -> str:
        # [cw/ccw] (start) ('diameter') (end)
        # diameter is really the point exactly 180 degrees from start
        begin = p2c()
        end   = 
        return f"arc '{name}' cw;"

preamble = """
GRID mm;
CHANGE WIDTH 2;
LAYER 1;

"""

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
