#!/usr/bin/env python3.7

# Imports:
from __future__ import annotations
from math import sin, cos, atan2, pi, radians, degrees, hypot
from tkinter import Canvas, Frame, Scrollbar, Tk, N, E, S, W
from typing import Iterable, List, Tuple

import tkinter as tk

# Constants:
SCALE = 5

# Types:
Radians = float
Degrees = float

class Drawable:
    def draw(self, canvas: Canvas, scale: float):
        pass

class AsEagle:
    name: str = ""

    def to_eagle(self) -> str:
        return self.as_eagle(self.name)

    def as_eagle(self, name: str) -> str:
        pass

class Point(object):
    """A simple 2D Point. All angles are in radians."""

    x: float = 0
    y: float = 0

    def __init__(self, x: float, y: float):
        self.x, self.y = x, y

    @classmethod
    def from_tuple(cls, t: Tuple[float, float]):
        return cls(*t)

    @classmethod
    def from_polar(cls, radius: float, angle: Radians):
        return cls(cos(angle) * radius, sin(angle) * radius)

    def as_tuple(self) -> Tuple[float, float]:
        return (self.x, self.y)

    def as_tk(self, scale: float) -> Tuple[float, float]:
        return (self.x * scale, -self.y * scale)

    def magnitude(self) -> float:
        return hypot(self.x, self.y)

    def relative_angle(self, other: Point) -> float:
        return atan2((other.y - self.y), (other.x - self.x)) % (2 * pi)

    def __str__(self) -> str:
        return f"({self.x} {self.y})"

    def __add__(self, other: Point) -> Point:
        return Point(self.x + other.x, self.y + other.y)

    def __sub__(self, other: Point) -> Point:
        return Point(self.x - other.x, self.y - other.y)

    def __mul__(self, other: float) -> Point:
        return Point(self.x * other, self.y * other)

    def __truediv__(self, other: float) -> Point:
        return Point(self.x / other, self.y / other)

    def __getitem__(self, idx) -> float:
        if idx == 0:
            return self.x
        elif idx == 1:
            return self.y
        else:
            raise IndexError(f"Invalid index for Point: {idx}")

class AsCoords:
    @staticmethod
    def repeat(num: int, *points: Point) -> Iterable[float]:
        for p in points:
            for n in range(num):
                yield p[0]
                yield p[1]

    def as_coords(self) -> Iterable[float]:
        pass

class Geo(AsCoords, AsEagle, Drawable, object):
    """A Geometric Primitive. For example, a line."""

class Polygon(AsEagle, Drawable, object):
    """A bundle of geometric primitives."""

    geos: List[Geo] = []

    def __init__(self, name: str, *geos: Geo):
        self.name = name
        self.geos = list(geos)

    @classmethod
    def from_points(cls, name: str, *pts: Tuple[float, float]):
        return cls(name, *[Line(*p1, *p2) for (p1, p2) in zip(pts, pts[1:])])

    def draw(self, canvas: Canvas, scale: float):
        # canvas.create_polygon(
        #     [scale * coord for geo in self.geos for coord in geo.as_coords()],
        #     fill = "red",
        #     outline = "grey",
        #     width = 2,
        #     smooth = True
        # )

        for geo in self.geos:
            geo.draw(canvas, scale)

    def as_eagle(self, name: str) -> str:
        first = self.geos[0].as_coords()
        first = Point(next(first), next(first))

        out = '\n'.join(geo.as_eagle(name) for geo in self.geos)

        return out + f"\npolygonize {first};"

    def as_list(self) -> List[Geo]:
        return self.geos

    def add_geos(self, *geos: Geo):
        self.geos += geos

class Line(Geo):
    p1: Point = (0, 0)
    p2: Point = (0, 0)

    def __init__(self, x1, y1, x2, y2):
        self.p1, self.p2 = Point(x1, y1), Point(x2, y2)

    def draw(self, canvas: Canvas, scale: float):
        canvas.create_line(
            *self.p1.as_tk(scale),
            *self.p2.as_tk(scale),
            fill = "red",
            width = 2,
        )

    def as_coords(self) -> Iterable[float]:
        return self.repeat(2, self.p1, self.p2)

    def as_eagle(self, name: str) -> str:
        return f"line '{name}' {self.p1} {self.p2};"

    def __str__(self) -> str:
        return f"Line {{ {self.p1} -> {self.p2} }}"

class Arc(Geo):
    """Represents an arc as a center, a radius, and starting/ending angles.

    Note: the Arc represented will go counterclockwise from the starting angle
    to the ending angle. 0 degrees is on the positive side of the x axis.

    Note: angles are in *radians*.
    """

    center: Point = (0, 0)
    radius: float = 0
    starting: float = 0
    ending: float = 0

    def __init__(self, x: float, y: float, radius: float, starting: Radians,
            ending: Radians):
        self.center, self.radius = Point(x, y), radius
        self.starting, self.ending = starting % (2 * pi), ending % (2 * pi)

        print(self.center, self.radius, degrees(self.starting), degrees(self.ending))

    @classmethod
    def from_polar(cls, center: Point, radius: float, starting_angle: Degrees,
            ending_angle: Degrees):
        return cls(*center.as_tuple(), radius, radians(starting_angle),
                radians(ending_angle))

    @classmethod
    def new(cls, center: Tuple[float, float], radius: float,
            starting_angle: Degrees, degrees: Degrees):
        return cls(*center, radius, radians(starting_angle),
                radians((starting_angle + degrees) % 360))

    @classmethod
    def from_points(cls, begin: Point, diam: Point, end: Point):
        mid = ((diam - begin) / 2)

        center = begin + mid
        radius = mid.magnitude()
        starting = center.relative_angle(begin)
        ending   = center.relative_angle(end)

        return cls(*center.as_tuple(), radius, starting, ending)

    def draw(self, canvas: Canvas, scale: float):
        # create_oval starts at `start` and goes CCW `extent` degrees:
        # takes top left/bottom right coordinates of the corresponding circle

        r = Point(self.radius, self.radius)

        canvas.create_arc(
            *(self.center - r).as_tk(scale),
            *(self.center + r).as_tk(scale),
            start = degrees(self.starting),
            extent = degrees(((self.ending + 2*pi) - self.starting) % (2*pi)),
            fill = "red",
            outline = "grey",
            width = 2,
            style = tk.ARC,
            # style = tk.PIESLICE,
        )

    def as_coords(self) -> Iterable[float]:
        return self.repeat(1,
                self.center + Point.from_polar(self.radius, self.starting),
                self.center + Point.from_polar(self.radius, self.ending))

    def as_eagle(self, name: str) -> str:
        # [cw/ccw] (start) ('diameter') (end)
        # diameter is really the point exactly 180 degrees from start
        begin = self.center + Point.from_polar(self.radius, self.starting)
        diam  = self.center - Point.from_polar(self.radius, self.starting)
        end   = self.center + Point.from_polar(self.radius, self.ending)
        return f"arc '{name}' ccw {begin} {diam} {end};"

preamble = """# Creates some wheels.
#
# Warning: This was auto-generated.
GRID mm;
CHANGE WIDTH 0.5;
LAYER 1;
"""

def channel(angle: Radians, width: Radians, outer_rad: float, inner_rad: float,
        bands: int) -> Polygon:
    # <= 4mm on the outer ring:
    sep_angle = (3.5 / (outer_rad)) / 2

    # 5 to 1 ratio for starting frill width to ending frill width:
    # We'll have `bands` frills, each separated by the ending frill width
    # (so that frills can be interlaced). This means `bands` * (starting
    # frill width + ending frill width) = (outer_rad - inner_rad).
    band_width = (outer_rad - inner_rad) / bands
    frill_starting = (5 / 6) * band_width
    frill_ending   = (1 / 6) * band_width
    frill_length = width - sep_angle

    if frill_starting > 4:
        print("Add more bands!!")

    # First left (halved):
    yield []

    for i in range(bands):
        # Left (CCW):
        



        # Right (CW):

    print(frill_starting, frill_ending)


# Assumes 3 channels and outer_rad/inner_rad in mm
def wheel_coords(outer_rad, inner_rad, bands):
    sep_angle = (3.5 / (outer_rad))

    # 5 to 1 ratio for starting frill width to ending frill width:

    outer_circle = (-outer_rad, -outer_rad, outer_rad, outer_rad)
    inner_circle = (-inner_rad, -inner_rad, inner_rad, inner_rad)

    ch = lambda angle: channel(radians(angle), radians(240), outer_rad, inner_rad, bands)

    return ([ inner_circle, outer_circle ], ch(0), ch(120), ch(240))


OUTER_RAD = 50
INNER_RAD = 15
BANDS = 8

SCALE = 7

def draw_wheel(canvas):
    coords = wheel_coords(OUTER_RAD, INNER_RAD, BANDS)

    base = coords[0]

    canvas.create_oval(*sc(*base[0]), fill = "grey")
    canvas.create_oval(*sc(*base[1]), outline = "red")

"""
def printcoords(event):
    (x, y) = (event.x, event.y)
    print (x / SCALE, y / SCALE)

if __name__ == "__main__":
    root = Tk()

    #setting up a tkinter canvas with scrollbars
    frame = Frame(root, bd=2, relief=tk.SUNKEN)
    frame.grid_rowconfigure(0, weight=1)
    frame.grid_columnconfigure(0, weight=1)
    xscroll = Scrollbar(frame, orient=tk.HORIZONTAL)
    xscroll.grid(row=1, column=0, sticky=E+W)
    yscroll = Scrollbar(frame)
    yscroll.grid(row=0, column=1, sticky=N+S)
    canvas = Canvas(frame, bd=0, xscrollcommand=xscroll.set, yscrollcommand=yscroll.set)
    canvas.grid(row=0, column=0, sticky=N+S+E+W)
    xscroll.config(command=canvas.xview)
    yscroll.config(command=canvas.yview)
    frame.pack(fill=tk.BOTH,expand=1)

    canvas.create_image(0,0,anchor="sw")

    draw_wheel(canvas)

    canvas.config(scrollregion=canvas.bbox(tk.ALL))
    canvas.bind("<Button 1>", printcoords)

    root.mainloop()
