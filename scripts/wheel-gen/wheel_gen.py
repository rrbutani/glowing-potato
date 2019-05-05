#!/usr/bin/env python3.7

# Imports:
from __future__ import annotations
from math import sin, cos, atan2, pi, radians, degrees, hypot
from tkinter import Canvas, Frame, Scrollbar, Tk, N, E, S, W
from typing import Iterable, List, Tuple, Generator

import tkinter as tk

# Constants:
SCALE = 10

# Types:
Radians = float
Degrees = float

class Drawable:

    fill: str = "red"
    outline: str = "blue"

    def draw(self, canvas: Canvas, scale: float):
        pass

    def set_fill(self, color: str):
        self.fill = color

        return self

    def set_outline(self, color: str):
        self.outline = color

        return self

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

    def relative_angle(self, other: Point) -> Radians:
        return atan2((other.y - self.y), (other.x - self.x)) % (2 * pi)

    def relative_polar(self, other: Point) -> Tuple[float, Radians]:
        return ((other - self).magnitude(), self.relative_angle(other))

    def __str__(self) -> str:
        return f"({round(self.x, 5)} {round(self.y, 5)})"

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
    def repeat(num: int, *points: Point) -> Generator[float, None, None]:
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

        return out + f"\npolygonize {first};\n"

    def as_list(self) -> List[Geo]:
        return self.geos

    def add_geos(self, *geos: Geo):
        self.geos += geos

class Line(Geo):
    p1: Point = (0, 0)
    p2: Point = (0, 0)

    def __init__(self, x1, y1, x2, y2):
        self.p1, self.p2 = Point(x1, y1), Point(x2, y2)

    @classmethod
    def from_points(cls, p1: Point, p2: Point):
        return cls(*p1.as_tuple(), *p2.as_tuple())

    def draw(self, canvas: Canvas, scale: float):
        canvas.create_line(
            *self.p1.as_tk(scale),
            *self.p2.as_tk(scale),
            fill = self.fill,
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

    @classmethod
    def from_polar_radians(cls, center: Point, radius: float,
            starting_angle: Radians, ending_angle: Radians):
        return cls(*center.as_tuple(), radius, starting_angle, ending_angle)

    @classmethod
    def from_polar_degrees(cls, center: Point, radius: float,
            starting_angle: Degrees, ending_angle: Degrees):
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
            fill = self.fill,
            outline = self.outline,
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
GRID mm 1 1 dots on alt mm 1 mm;
CHANGE WIDTH 0.02;
SET wire_bend 2;
LAYER 1;
"""

# First, some definitions. In the diagram there are three of the same shape,
# each offset by 120 degrees and each a different color (light grey, grey, and
# black in the diagram). We're going to call these _channels_. The shape that
# each channel has is composed of curved triangle things: we're going to call
# these _frills_. There are frills going clockwise and counter-clockwise; all
# of these connect to a strip in the center of the channel which we'll call the
# _spine_.
#
# Each frill has a starting width (it's thickness at the point it connects to
# the spine) and an ending width (the thickness of it's pointy end). The sum of
# these two widths we'll call the _band width_. The idea is that we can divide
# the area of the wheel into bands each of which will be thick enough for one
# frill (since the arcs that comprise a frill aren't co-centric with the wheel,
# this isn't really true but it's a useful abstraction, I think).

# We're told that we should have a band width of 4 mm or less, so let's try 3.5
# mm for now:
BAND_WIDTH = 3.5

# We're also told that the edges of frills should be 4 mm or less apart. Let's
# try 3.5 mm for this as well:
FRILL_SEP = 3.5

# Note that we're assuming the spine has the same width as FRILL_SEP.

Frills = Tuple[float, float, List[float]]

def channel(name: str, center: Point, angle: Radians, width: Radians, frills: Frills, color: str) -> Polygon:

    inner_rad, outer_rad, radii = frills
    p = Polygon(name)

    # Let's start with the bottom of the spine:
    # We want its arc length to be exactly FRILL_SEP, meaning half of that on
    # either side of `angle`.
    w = FRILL_SEP / inner_rad / 2
    p.add_geos(Arc.from_polar_radians(center, inner_rad, angle - w, angle + w).set_outline("purple"))

    # We're going to draw the lines on the sides of the spine by keeping track
    # of the last point for the left/right and drawing a straight lint from
    # there to our current position.
    #
    # Since we start with the bottom of the spine, let's use that for the
    # initial values:
    last_spine_points: List[Point] = [
        center + Point.from_polar(inner_rad, angle + w), # CCW
        center + Point.from_polar(inner_rad, angle - w), # CW
    ]

    # Band spec:
    # |  +++++++++  --|
    # + : starting frill
    # - : ending frill
    #   : gap
    # total    : 14.3 :: 16
    # starting : 11.6 :: 13
    # ending   : 0.95 ::  1+
    # gap 1    : 0.9  ::  1
    # gap 2    : 0.9  ::  1
    #
    # Each radius corresponds to a point in the middle of the starting side of
    # the frill.
    BAND_TOTAL = 16
    BAND_START = 13
    BAND_END   =  1
    BAND_GAP   =  1

    # We have 4 different centers. One for the top of the frill and one for the
    # bottom with separate centers for clockwise and counter clockwise frills.
    #
    # Really all the centers are on a circle centered at the actual center; top
    # and bottom centers should be directly across from each other (180 degrees
    # between them) on this circle. Additionally, our clockwise frill centers
    # should be identical to the counterclockwise frill centers for the channel
    # that's clockwise adjacent to us.
    #
    # Since these centers are on a circle, it makes sense to use polar form to
    # find them. The angle of each center is a function of this channel's
    # angle. The radius of the circle is determined by the bandwidth.
    #
    # NOTE: I haven't done the math for scaling the radius of this circle.
    # Experimentally, for band widths of about 4 the radius of the circle
    # appeared to be about 1, hence the scale factor of 4:
    # center_circle_point:
    ccp = lambda a: Point.from_polar(BAND_WIDTH / 4.3, angle + a) + center

    # Appears to be +25 degrees for bottom and +205 degrees for top (180 + 25):
    cw_ccp_offset = 210
    cw_btm_center = ccp(radians(cw_ccp_offset))
    cw_top_center = ccp(radians(cw_ccp_offset + 180))

    # Appears to be +150 degrees for bottom and +330 degrees for top:
    ccw_ccp_offset = 150
    ccw_btm_center = ccp(radians(ccw_ccp_offset))
    ccw_top_center = ccp(radians(ccw_ccp_offset + 180))

    # Radii alternate between CW and CCW; we start with CCW:
    cw: bool = False
    for rad in radii:
        center_top = cw_top_center if cw else ccw_top_center
        center_btm = cw_btm_center if cw else ccw_btm_center

        # Given the middle of the starting frill, we can calculate the radii of
        # the top/bottom:
        starting_top = rad + ((BAND_START / BAND_TOTAL) / 2) * BAND_WIDTH
        starting_btm = rad - ((BAND_START / BAND_TOTAL) / 2) * BAND_WIDTH

        # And also the ending top/bottom:
        ending_top = rad - (BAND_WIDTH / 2) + \
            (((BAND_START / 2) + BAND_GAP + BAND_END) / BAND_TOTAL) * BAND_WIDTH
        ending_btm = rad - (BAND_WIDTH / 2) + \
            (((BAND_START / 2) + BAND_GAP) / BAND_TOTAL) * BAND_WIDTH

        # The first and last radii are potentially special cases since they can
        # begin or end on the inner/outer circle. Rather than handle those
        # outside of the loop we'll just do a quick check here:
        if starting_top >= outer_rad or ending_top >= outer_rad:
            starting_top = outer_rad

            if ending_top >= outer_rad:
                # We might have to do this regardless since we're swapping the
                # center..
                ending_top = outer_rad

                # Note: this shouldn't really happen and likely won't work
                if ending_btm >= outer_rad:
                    ending_btm = outer_rad
                    center_btm = center
                    print("Warning: zero width frill end")

            # Note: this also shouldn't really happen and likely won't work
            if starting_btm >= outer_rad:
                starting_btm = outer_rad
                center_btm = center
                print("Warning: zero width frill start (not good!)")

            center_top = center

        # Checking that we don't go into the inner circle is a bit easier since
        # we can assume that the starting top and ending top aren't problematic:
        if starting_btm <= inner_rad or ending_btm <= inner_rad:
            # I'm making a simplifying assumption here: if we swap the starting
            # bottom we're going to want to swap the ending bottom too.
            # It _is_ possible to have the starting bottom go into the inner
            # circle while the ending bottom doesn't but this _should_ never
            # happen with the current setup.

            starting_btm = inner_rad
            ending_btm = inner_rad

            center_btm = center

        # Armed with what I sincerely hope are correct radii, we can now
        # calculate positions for our points.
        # Our starting positions should be half of FRILL_SEP away from this
        # channel's angle and our ending positions should be FRILL_SEP / 2 +
        # BAND_GAP away from the end of this channel (angle + width / 2).
        #
        # If we're cw we want to subtract; otherwise add.
        war = width_at_radius = lambda l, r: (l / r) * (-1 if cw else 1)
        swar = spine_width_at_radius = lambda r: war((FRILL_SEP / 2), r)
        ewar = end_width_at_radius = lambda r: war((FRILL_SEP / 2) + (BAND_GAP / BAND_TOTAL) * BAND_WIDTH, r)
        w = (width / 2) * (-1 if cw else 1)

        starting_top: Point = \
            center + Point.from_polar(starting_top, angle + swar(starting_top))
        starting_btm: Point = \
            center + Point.from_polar(starting_btm, angle + swar(starting_btm))

        ending_top: Point = \
            center + Point.from_polar(ending_top, angle + w - ewar(ending_top))
        ending_btm: Point = \
            center + Point.from_polar(ending_btm, angle + w - ewar(ending_btm))

        # From these points we should be able to construct our arcs and lines:
        st_rad, st_ang = center_top.relative_polar(starting_top)
        sb_rad, sb_ang = center_btm.relative_polar(starting_btm)

        et_rad, et_ang = center_top.relative_polar(ending_top)
        eb_rad, eb_ang = center_btm.relative_polar(ending_btm)

        # Takes starting, ending; flips correctly (CCW):
        ao = angle_order = lambda s, e: (e, s) if cw else (s, e)

        def check(a, b):
            d = a - b
            if abs(d) > 0.1:
                print(f"Arc coordinates don't match the circle!! (diff of {d})")

        check(sb_rad, eb_rad)
        check(st_rad, et_rad)

        p.add_geos(
            Line.from_points(last_spine_points[cw], starting_btm)
                .set_fill(color),
            Arc.from_polar_radians(center_btm, sb_rad, *ao(sb_ang, eb_ang))
                .set_outline(color),
            # This is the right one:
            # Line.from_points(ending_top, ending_btm)
            #     .set_fill(color),
            #
            # But, since the points on the arcs don't actually match, let's use
            # the points on the arcs to make the line:
            Line.from_points(center_btm + Point.from_polar(sb_rad, eb_ang),
                center_top + Point.from_polar(st_rad, et_ang))
                    .set_fill(color),
            Arc.from_polar_radians(center_top, st_rad, *ao(st_ang, et_ang))
                .set_outline(color),
        )

        last_spine_points[cw] = starting_top

        cw = not cw

    # Finally, let's do the top of the spine:
    w = FRILL_SEP / outer_rad / 2
    p.add_geos(Arc.from_polar_radians(center, outer_rad, angle - w, angle + w).set_outline("purple"))

    # Now all that's left is to connect this to the last spine points:
    p.add_geos(
        Line.from_points(last_spine_points[0],
            center + Point.from_polar(outer_rad, angle + w))
                .set_fill(color),
        Line.from_points(last_spine_points[1],
            center + Point.from_polar(outer_rad, angle - w))
                .set_fill(color),
    )

    return p

def calculate_frill_positions(inner_rad: float, outer_rad: float) -> Bands:
    # Here we're going to calculate the radii (distance from the center) for
    # the middle of the starting width of each of the frills.
    radii = []

    # The first frill should start at 0. We're going to assume that left and
    # right frills are staggered by half the width of a band.
    radius = inner_rad
    while radius < outer_rad:
        radii.append(radius)

        radius += (BAND_WIDTH / 2)

    return (inner_rad, outer_rad, radii)

Circle = Tuple[float, float, float, float]
Coords = Tuple[Tuple[Circle, Circle], List[Polygon]]

colors = ["red", "blue", "green", "yellow", "orange", "pink"]

# Assumes 3 channels and outer_rad/inner_rad in mm
def wheel_coords(inner_rad, outer_rad, center_x, center_y, channels) -> Coords:
    i, o, x, y = inner_rad, outer_rad, center_x, center_y
    outer_circle: Circle = (x - o, -(y - o), x + o, -(y + o))
    inner_circle: Circle = (x - i, -(y - i), x + i, -(y + i))

    frills = calculate_frill_positions(inner_rad, outer_rad)
    center = Point(center_x, center_y)

    width = (360 * 2) / channels
    ch = lambda num, a, c: channel(f"CH{num}", center, radians(a), radians(width), frills, c)

    # We want to start at the top so start with 90:
    offset, chs = 90, channels
    polys = [ ch(chs - i - 1, offset + (i * (width / 2)), colors[i]) for i in range(chs) ]

    return ((inner_circle, outer_circle), polys)


OUTER_RAD = 18
INNER_RAD = 6.2
CHANNELS  = 3

def scale(scale: float, *args: float) -> Generator[float, None, None]:
    for i in args:
        yield scale * i

def draw_wheel(canvas, inner_rad = INNER_RAD, outer_rad = OUTER_RAD, center_x = 0, center_y = 0, channels = CHANNELS):
    coords = wheel_coords(inner_rad, outer_rad, center_x, center_y, channels)

    base, polys = coords

    sc = lambda *a: scale(SCALE, *a)

    canvas.create_oval(*sc(*base[0]), fill = "grey")
    canvas.create_oval(*sc(*base[1]), outline = "red")

    with open("wheel.scr", "w") as f:
        f.write(preamble + "\n")

        for p in polys:
            p.draw(canvas, SCALE)
            f.write(p.to_eagle() + "\n")

        f.write("ratsnest;\n")

        print("Wrote wheel.scr")

def printcoords(event):
    (x, y) = (event.x, event.y)
    print(x / SCALE, y / SCALE)


from tkinter import *
if __name__ == "__main__":
    root = Tk()

    m = PanedWindow(orient=HORIZONTAL)
    m.pack(fill=BOTH, expand=0)

    center_x = tk.DoubleVar()
    center_x.set(0)
    center_y = tk.DoubleVar()
    center_y.set(0)

    m.add(Label(m, text="Center:"))
    m.add(tk.Entry(textvariable=center_x))
    m.add(tk.Entry(textvariable=center_y))

    inner_rad = tk.DoubleVar()
    inner_rad.set(INNER_RAD)
    outer_rad = tk.DoubleVar()
    outer_rad.set(OUTER_RAD)

    m.add(Label(m, text="Inner radius:"))
    m.add(tk.Entry(textvariable=inner_rad))
    m.add(Label(m, text="Outer radius:"))
    m.add(tk.Entry(textvariable=outer_rad))

    channels = tk.IntVar()
    channels.set(CHANNELS)

    m.add(Label(m, text="Channels:"))
    m.add(tk.Entry(textvariable=channels))

    scale_factor = tk.IntVar()
    scale_factor.set(SCALE)

    m.add(Label(m, text="Scale factor:"))
    m.add(tk.Entry(textvariable=scale_factor))

    band_width = tk.IntVar()
    band_width.set(BAND_WIDTH)

    m.add(Label(m, text="Band width:"))
    m.add(tk.Entry(textvariable=band_width))

    frill_sep = tk.DoubleVar()
    frill_sep.set(FRILL_SEP)

    m.add(Label(m, text="Frill sep:"))
    m.add(tk.Entry(textvariable=frill_sep))


    # #setting up a tkinter canvas with scrollbars
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

    def run():
        global SCALE, BAND_WIDTH, FRILL_SEP
        SCALE = scale_factor.get()
        BAND_WIDTH = band_width.get()
        FRILL_SEP = frill_sep.get()
        canvas.delete("all")
        draw_wheel(canvas, inner_rad.get(), outer_rad.get(), center_x.get(), center_y.get(), channels.get())
        canvas.config(scrollregion=canvas.bbox(tk.ALL))

    go = tk.Button(m, text="Run!", command=run)
    m.add(go)

    draw_wheel(canvas)
    canvas.config(scrollregion=canvas.bbox(tk.ALL))

    canvas.bind("<Button 1>", printcoords)

    root.mainloop()
