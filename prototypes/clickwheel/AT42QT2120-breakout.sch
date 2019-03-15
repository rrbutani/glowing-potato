<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.2.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="16" fill="1" visible="no" active="no"/>
<layer number="3" name="Route3" color="17" fill="1" visible="no" active="no"/>
<layer number="4" name="Route4" color="18" fill="1" visible="no" active="no"/>
<layer number="5" name="Route5" color="19" fill="1" visible="no" active="no"/>
<layer number="6" name="Route6" color="25" fill="1" visible="no" active="no"/>
<layer number="7" name="Route7" color="26" fill="1" visible="no" active="no"/>
<layer number="8" name="Route8" color="27" fill="1" visible="no" active="no"/>
<layer number="9" name="Route9" color="28" fill="1" visible="no" active="no"/>
<layer number="10" name="Route10" color="29" fill="1" visible="no" active="no"/>
<layer number="11" name="Route11" color="30" fill="1" visible="no" active="no"/>
<layer number="12" name="Route12" color="20" fill="1" visible="no" active="no"/>
<layer number="13" name="Route13" color="21" fill="1" visible="no" active="no"/>
<layer number="14" name="Route14" color="22" fill="1" visible="no" active="no"/>
<layer number="15" name="Route15" color="23" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="24" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="pinhead" urn="urn:adsk.eagle:library:325">
<description>&lt;b&gt;Pin Header Connectors&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="1X03" urn="urn:adsk.eagle:footprint:22340/1" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-3.175" y1="1.27" x2="-1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="0.635" x2="-1.27" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-0.635" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="0.635" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="0.635" x2="1.27" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-0.635" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.27" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="0.635" x2="-3.81" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-3.81" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="-0.635" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-1.27" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.27" y1="0.635" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="3.81" y2="0.635" width="0.1524" layer="21"/>
<wire x1="3.81" y1="0.635" x2="3.81" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="3.81" y1="-0.635" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-1.27" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="1.27" y2="-0.635" width="0.1524" layer="21"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="0" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="2.54" y="0" drill="1.016" shape="long" rot="R90"/>
<text x="-3.8862" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.81" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.254" y1="-0.254" x2="0.254" y2="0.254" layer="51"/>
<rectangle x1="-2.794" y1="-0.254" x2="-2.286" y2="0.254" layer="51"/>
<rectangle x1="2.286" y1="-0.254" x2="2.794" y2="0.254" layer="51"/>
</package>
<package name="1X02/90" urn="urn:adsk.eagle:footprint:22310/1" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-2.54" y1="-1.905" x2="0" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="0" y1="-1.905" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="6.985" x2="-1.27" y2="1.27" width="0.762" layer="21"/>
<wire x1="0" y1="-1.905" x2="2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="6.985" x2="1.27" y2="1.27" width="0.762" layer="21"/>
<pad name="1" x="-1.27" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="1.27" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<text x="-3.175" y="-3.81" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="4.445" y="-3.81" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
<rectangle x1="-1.651" y1="0.635" x2="-0.889" y2="1.143" layer="21"/>
<rectangle x1="0.889" y1="0.635" x2="1.651" y2="1.143" layer="21"/>
<rectangle x1="-1.651" y1="-2.921" x2="-0.889" y2="-1.905" layer="21"/>
<rectangle x1="0.889" y1="-2.921" x2="1.651" y2="-1.905" layer="21"/>
</package>
<package name="1X03/90" urn="urn:adsk.eagle:footprint:22341/1" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-3.81" y1="-1.905" x2="-1.27" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-1.905" x2="-1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="0.635" x2="-3.81" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="0.635" x2="-3.81" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="6.985" x2="-2.54" y2="1.27" width="0.762" layer="21"/>
<wire x1="-1.27" y1="-1.905" x2="1.27" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-1.905" x2="1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="0.635" x2="-1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="6.985" x2="0" y2="1.27" width="0.762" layer="21"/>
<wire x1="1.27" y1="-1.905" x2="3.81" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="3.81" y1="-1.905" x2="3.81" y2="0.635" width="0.1524" layer="21"/>
<wire x1="3.81" y1="0.635" x2="1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="6.985" x2="2.54" y2="1.27" width="0.762" layer="21"/>
<pad name="1" x="-2.54" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="0" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="2.54" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<text x="-4.445" y="-3.81" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="5.715" y="-3.81" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
<rectangle x1="-2.921" y1="0.635" x2="-2.159" y2="1.143" layer="21"/>
<rectangle x1="-0.381" y1="0.635" x2="0.381" y2="1.143" layer="21"/>
<rectangle x1="2.159" y1="0.635" x2="2.921" y2="1.143" layer="21"/>
<rectangle x1="-2.921" y1="-2.921" x2="-2.159" y2="-1.905" layer="21"/>
<rectangle x1="-0.381" y1="-2.921" x2="0.381" y2="-1.905" layer="21"/>
<rectangle x1="2.159" y1="-2.921" x2="2.921" y2="-1.905" layer="21"/>
</package>
<package name="1X02" urn="urn:adsk.eagle:footprint:22309/1" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-1.905" y1="1.27" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<pad name="1" x="-1.27" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="1.27" y="0" drill="1.016" shape="long" rot="R90"/>
<text x="-2.6162" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
</package>
<package name="1X01" urn="urn:adsk.eagle:footprint:22382/1" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-0.635" y1="1.27" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="0.635" x2="1.27" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-0.635" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="0.635" x2="-1.27" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="-1.27" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<pad name="1" x="0" y="0" drill="1.016" shape="octagon"/>
<text x="-1.3462" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.27" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.254" y1="-0.254" x2="0.254" y2="0.254" layer="51"/>
</package>
</packages>
<packages3d>
<package3d name="1X03" urn="urn:adsk.eagle:package:22458/2" type="model" library_version="3">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X03"/>
</packageinstances>
</package3d>
<package3d name="1X02/90" urn="urn:adsk.eagle:package:22437/2" type="model" library_version="3">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X02/90"/>
</packageinstances>
</package3d>
<package3d name="1X03/90" urn="urn:adsk.eagle:package:22459/2" type="model" library_version="3">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X03/90"/>
</packageinstances>
</package3d>
<package3d name="1X02" urn="urn:adsk.eagle:package:22435/2" type="model" library_version="3">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X02"/>
</packageinstances>
</package3d>
<package3d name="1X01" urn="urn:adsk.eagle:package:22485/2" type="model" library_version="3">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X01"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="PINHD2" urn="urn:adsk.eagle:symbol:22308/1" library_version="3">
<wire x1="-6.35" y1="-2.54" x2="1.27" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="1.27" y2="5.08" width="0.4064" layer="94"/>
<wire x1="1.27" y1="5.08" x2="-6.35" y2="5.08" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="5.08" x2="-6.35" y2="-2.54" width="0.4064" layer="94"/>
<text x="-6.35" y="5.715" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-5.08" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
<symbol name="PINHD3" urn="urn:adsk.eagle:symbol:22339/1" library_version="3">
<wire x1="-6.35" y1="-5.08" x2="1.27" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="1.27" y2="5.08" width="0.4064" layer="94"/>
<wire x1="1.27" y1="5.08" x2="-6.35" y2="5.08" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="5.08" x2="-6.35" y2="-5.08" width="0.4064" layer="94"/>
<text x="-6.35" y="5.715" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-7.62" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="3" x="-2.54" y="-2.54" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
<symbol name="PINHD1" urn="urn:adsk.eagle:symbol:22381/1" library_version="3">
<wire x1="-6.35" y1="-2.54" x2="1.27" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="1.27" y2="2.54" width="0.4064" layer="94"/>
<wire x1="1.27" y1="2.54" x2="-6.35" y2="2.54" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="2.54" x2="-6.35" y2="-2.54" width="0.4064" layer="94"/>
<text x="-6.35" y="3.175" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-5.08" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="PINHD-1X2" urn="urn:adsk.eagle:component:22516/3" prefix="JP" uservalue="yes" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="PINHD2" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X02">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22435/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="/90" package="1X02/90">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22437/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="PINHD-1X3" urn="urn:adsk.eagle:component:22524/3" prefix="JP" uservalue="yes" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="A" symbol="PINHD3" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X03">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22458/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="/90" package="1X03/90">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22459/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="PINHD-1X1" urn="urn:adsk.eagle:component:22540/2" prefix="JP" uservalue="yes" library_version="3">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="PINHD1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X01">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22485/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="AT42QT2120">
<description>Atmel's AT42AT2120 in comms/standalone modes and XU and SU variants (TSSOP and SOIC respectively).</description>
<packages>
<package name="SO20W" urn="urn:adsk.eagle:footprint:30968/1" locally_modified="yes">
<description>&lt;b&gt;SMALL OUTLINE INTEGRATED CIRCUIT&lt;/b&gt;&lt;p&gt;
wide body 7.5 mm/JEDEC MS-013AC</description>
<wire x1="6.46" y1="-3.7" x2="-6.46" y2="-3.7" width="0.2032" layer="51"/>
<wire x1="-6.46" y1="-3.7" x2="-6.46" y2="-2.565" width="0.2032" layer="51"/>
<wire x1="-6.46" y1="-2.565" x2="-6.46" y2="3.7" width="0.2032" layer="51"/>
<wire x1="-6.46" y1="3.7" x2="6.46" y2="3.7" width="0.2032" layer="51"/>
<wire x1="6.46" y1="-2.565" x2="-6.46" y2="-2.565" width="0.2032" layer="51"/>
<wire x1="6.46" y1="3.7" x2="6.46" y2="-2.565" width="0.2032" layer="51"/>
<wire x1="6.46" y1="-2.565" x2="6.46" y2="-3.7" width="0.2032" layer="51"/>
<smd name="2" x="-4.445" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="13" x="3.175" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="1" x="-5.715" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="3" x="-3.175" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="4" x="-1.905" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="14" x="1.905" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="12" x="4.445" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="11" x="5.715" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="6" x="0.635" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="9" x="4.445" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="5" x="-0.635" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="7" x="1.905" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="10" x="5.715" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="8" x="3.175" y="-4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="15" x="0.635" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="16" x="-0.635" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="17" x="-1.905" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="18" x="-3.175" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="19" x="-4.445" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<smd name="20" x="-5.715" y="4.6" dx="0.6" dy="2.2" layer="1"/>
<text x="-3.175" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-1.651" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-5.9601" y1="-5.32" x2="-5.4699" y2="-3.8001" layer="51"/>
<rectangle x1="-4.6901" y1="-5.32" x2="-4.1999" y2="-3.8001" layer="51"/>
<rectangle x1="-3.4201" y1="-5.32" x2="-2.9299" y2="-3.8001" layer="51"/>
<rectangle x1="-2.1501" y1="-5.32" x2="-1.6599" y2="-3.8001" layer="51"/>
<rectangle x1="-0.8801" y1="-5.32" x2="-0.3899" y2="-3.8001" layer="51"/>
<rectangle x1="0.3899" y1="-5.32" x2="0.8801" y2="-3.8001" layer="51"/>
<rectangle x1="1.6599" y1="-5.32" x2="2.1501" y2="-3.8001" layer="51"/>
<rectangle x1="2.9299" y1="-5.32" x2="3.4201" y2="-3.8001" layer="51"/>
<rectangle x1="4.1999" y1="-5.32" x2="4.6901" y2="-3.8001" layer="51"/>
<rectangle x1="5.4699" y1="-5.32" x2="5.9601" y2="-3.8001" layer="51"/>
<rectangle x1="5.4699" y1="3.8001" x2="5.9601" y2="5.32" layer="51"/>
<rectangle x1="4.1999" y1="3.8001" x2="4.6901" y2="5.32" layer="51"/>
<rectangle x1="2.9299" y1="3.8001" x2="3.4201" y2="5.32" layer="51"/>
<rectangle x1="1.6599" y1="3.8001" x2="2.1501" y2="5.32" layer="51"/>
<rectangle x1="0.3899" y1="3.8001" x2="0.8801" y2="5.32" layer="51"/>
<rectangle x1="-0.8801" y1="3.8001" x2="-0.3899" y2="5.32" layer="51"/>
<rectangle x1="-2.1501" y1="3.8001" x2="-1.6599" y2="5.32" layer="51"/>
<rectangle x1="-3.4201" y1="3.8001" x2="-2.9299" y2="5.32" layer="51"/>
<rectangle x1="-4.6901" y1="3.8001" x2="-4.1999" y2="5.32" layer="51"/>
<rectangle x1="-5.9601" y1="3.8001" x2="-5.4699" y2="5.32" layer="51"/>
<wire x1="-6.35" y1="0.635" x2="-6.35" y2="-0.635" width="0.2032" layer="21" curve="-180"/>
</package>
<package name="TSSOP20" urn="urn:adsk.eagle:footprint:4239/1">
<description>&lt;b&gt;Thin Shrink Small Outline Plastic 20&lt;/b&gt;&lt;p&gt;
MAX3223-MAX3243.pdf</description>
<wire x1="-3.1646" y1="-2.2828" x2="3.1646" y2="-2.2828" width="0.1524" layer="21"/>
<wire x1="3.1646" y1="2.2828" x2="3.1646" y2="-2.2828" width="0.1524" layer="21"/>
<wire x1="3.1646" y1="2.2828" x2="-3.1646" y2="2.2828" width="0.1524" layer="21"/>
<wire x1="-3.1646" y1="-2.2828" x2="-3.1646" y2="2.2828" width="0.1524" layer="21"/>
<wire x1="-2.936" y1="-2.0542" x2="2.936" y2="-2.0542" width="0.0508" layer="21"/>
<wire x1="2.936" y1="2.0542" x2="2.936" y2="-2.0542" width="0.0508" layer="21"/>
<wire x1="2.936" y1="2.0542" x2="-2.936" y2="2.0542" width="0.0508" layer="21"/>
<wire x1="-2.936" y1="-2.0542" x2="-2.936" y2="2.0542" width="0.0508" layer="21"/>
<circle x="-2.2756" y="-1.2192" radius="0.4572" width="0.1524" layer="21"/>
<smd name="1" x="-2.925" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="2" x="-2.275" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="3" x="-1.625" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="4" x="-0.975" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="5" x="-0.325" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="6" x="0.325" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="7" x="0.975" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="8" x="1.625" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="9" x="2.275" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="10" x="2.925" y="-2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="11" x="2.925" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="12" x="2.275" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="13" x="1.625" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="14" x="0.975" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="15" x="0.325" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="16" x="-0.325" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="17" x="-0.975" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="18" x="-1.625" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="19" x="-2.275" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<smd name="20" x="-2.925" y="2.9178" dx="0.3048" dy="0.9906" layer="1"/>
<text x="-3.5456" y="-2.0828" size="1.016" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="4.5362" y="-2.0828" size="1.016" layer="27" ratio="10" rot="R90">&gt;VALUE</text>
<rectangle x1="-3.0266" y1="-3.121" x2="-2.8234" y2="-2.2828" layer="51"/>
<rectangle x1="-2.3766" y1="-3.121" x2="-2.1734" y2="-2.2828" layer="51"/>
<rectangle x1="-1.7266" y1="-3.121" x2="-1.5234" y2="-2.2828" layer="51"/>
<rectangle x1="-1.0766" y1="-3.121" x2="-0.8734" y2="-2.2828" layer="51"/>
<rectangle x1="-0.4266" y1="-3.121" x2="-0.2234" y2="-2.2828" layer="51"/>
<rectangle x1="0.2234" y1="-3.121" x2="0.4266" y2="-2.2828" layer="51"/>
<rectangle x1="0.8734" y1="-3.121" x2="1.0766" y2="-2.2828" layer="51"/>
<rectangle x1="1.5234" y1="-3.121" x2="1.7266" y2="-2.2828" layer="51"/>
<rectangle x1="2.1734" y1="-3.121" x2="2.3766" y2="-2.2828" layer="51"/>
<rectangle x1="2.8234" y1="-3.121" x2="3.0266" y2="-2.2828" layer="51"/>
<rectangle x1="2.8234" y1="2.2828" x2="3.0266" y2="3.121" layer="51"/>
<rectangle x1="2.1734" y1="2.2828" x2="2.3766" y2="3.121" layer="51"/>
<rectangle x1="1.5234" y1="2.2828" x2="1.7266" y2="3.121" layer="51"/>
<rectangle x1="0.8734" y1="2.2828" x2="1.0766" y2="3.121" layer="51"/>
<rectangle x1="0.2234" y1="2.2828" x2="0.4266" y2="3.121" layer="51"/>
<rectangle x1="-0.4266" y1="2.2828" x2="-0.2234" y2="3.121" layer="51"/>
<rectangle x1="-1.0766" y1="2.2828" x2="-0.8734" y2="3.121" layer="51"/>
<rectangle x1="-1.7266" y1="2.2828" x2="-1.5234" y2="3.121" layer="51"/>
<rectangle x1="-2.3766" y1="2.2828" x2="-2.1734" y2="3.121" layer="51"/>
<rectangle x1="-3.0266" y1="2.2828" x2="-2.8234" y2="3.121" layer="51"/>
</package>
</packages>
<packages3d>
<package3d name="SO20W" urn="urn:adsk.eagle:package:30991/2" locally_modified="yes" type="model">
<description>SMALL OUTLINE INTEGRATED CIRCUIT
wide body 7.5 mm/JEDEC MS-013AC</description>
<packageinstances>
<packageinstance name="SO20W"/>
</packageinstances>
</package3d>
<package3d name="TSSOP20" urn="urn:adsk.eagle:package:4349/2" type="model">
<description>Thin Shrink Small Outline Plastic 20
MAX3223-MAX3243.pdf</description>
<packageinstances>
<packageinstance name="TSSOP20"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="AT42QT2120-COMMS">
<description>Symbol for AT42QT2120 in comms mode (make sure MODE is tied to Vss for comms mode).</description>
<wire x1="-15.24" y1="30.48" x2="15.24" y2="30.48" width="0.254" layer="94"/>
<wire x1="15.24" y1="30.48" x2="15.24" y2="-30.48" width="0.254" layer="94"/>
<wire x1="15.24" y1="-30.48" x2="-15.24" y2="-30.48" width="0.254" layer="94"/>
<wire x1="-15.24" y1="-30.48" x2="-15.24" y2="30.48" width="0.254" layer="94"/>
<pin name="KEY8/GPO6" x="20.32" y="12.7" length="middle" rot="R180"/>
<pin name="KEY7/GPO5" x="20.32" y="7.62" length="middle" rot="R180"/>
<pin name="KEY6/GPO4" x="20.32" y="2.54" length="middle" rot="R180"/>
<pin name="KEY5/GPO3" x="20.32" y="-2.54" length="middle" rot="R180"/>
<pin name="KEY4/GPO2" x="20.32" y="-7.62" length="middle" rot="R180"/>
<pin name="KEY3/GPO1" x="20.32" y="-12.7" length="middle" rot="R180"/>
<pin name="KEY2/GPO0" x="20.32" y="-17.78" length="middle" rot="R180"/>
<pin name="KEY1" x="20.32" y="-22.86" length="middle" rot="R180"/>
<pin name="KEY0" x="20.32" y="-27.94" length="middle" rot="R180"/>
<pin name="VSS" x="-20.32" y="17.78" length="middle" direction="pwr"/>
<pin name="VDD" x="-20.32" y="12.7" length="middle" direction="pwr"/>
<pin name="MODE" x="-20.32" y="-27.94" length="middle" direction="in"/>
<pin name="SDA" x="-20.32" y="-12.7" length="middle" direction="oc"/>
<pin name="RESET" x="-20.32" y="27.94" length="middle" direction="in" function="dot"/>
<pin name="NC" x="-20.32" y="2.54" visible="off" length="middle" direction="nc"/>
<pin name="SCL" x="-20.32" y="-17.78" length="middle" direction="oc" function="clk"/>
<pin name="CHANGE" x="-20.32" y="-7.62" length="middle" direction="oc" function="dot"/>
<pin name="KEY11/GPO9" x="20.32" y="27.94" length="middle" rot="R180"/>
<pin name="KEY10/GPO8" x="20.32" y="22.86" length="middle" rot="R180"/>
<pin name="KEY9/GPO7" x="20.32" y="17.78" length="middle" rot="R180"/>
<text x="-5.08" y="33.02" size="1.778" layer="94">&gt;NAME</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="COMMS-AT42QT2120">
<gates>
<gate name="G$1" symbol="AT42QT2120-COMMS" x="0" y="0"/>
</gates>
<devices>
<device name="SU" package="SO20W">
<connects>
<connect gate="G$1" pin="CHANGE" pad="17"/>
<connect gate="G$1" pin="KEY0" pad="9"/>
<connect gate="G$1" pin="KEY1" pad="8"/>
<connect gate="G$1" pin="KEY10/GPO8" pad="19"/>
<connect gate="G$1" pin="KEY11/GPO9" pad="18"/>
<connect gate="G$1" pin="KEY2/GPO0" pad="7"/>
<connect gate="G$1" pin="KEY3/GPO1" pad="6"/>
<connect gate="G$1" pin="KEY4/GPO2" pad="5"/>
<connect gate="G$1" pin="KEY5/GPO3" pad="4"/>
<connect gate="G$1" pin="KEY6/GPO4" pad="3"/>
<connect gate="G$1" pin="KEY7/GPO5" pad="2"/>
<connect gate="G$1" pin="KEY8/GPO6" pad="1"/>
<connect gate="G$1" pin="KEY9/GPO7" pad="20"/>
<connect gate="G$1" pin="MODE" pad="12"/>
<connect gate="G$1" pin="NC" pad="15"/>
<connect gate="G$1" pin="RESET" pad="14"/>
<connect gate="G$1" pin="SCL" pad="16"/>
<connect gate="G$1" pin="SDA" pad="13"/>
<connect gate="G$1" pin="VDD" pad="11"/>
<connect gate="G$1" pin="VSS" pad="10"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:30991/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="XU" package="TSSOP20">
<connects>
<connect gate="G$1" pin="CHANGE" pad="17"/>
<connect gate="G$1" pin="KEY0" pad="9"/>
<connect gate="G$1" pin="KEY1" pad="8"/>
<connect gate="G$1" pin="KEY10/GPO8" pad="19"/>
<connect gate="G$1" pin="KEY11/GPO9" pad="18"/>
<connect gate="G$1" pin="KEY2/GPO0" pad="7"/>
<connect gate="G$1" pin="KEY3/GPO1" pad="6"/>
<connect gate="G$1" pin="KEY4/GPO2" pad="5"/>
<connect gate="G$1" pin="KEY5/GPO3" pad="4"/>
<connect gate="G$1" pin="KEY6/GPO4" pad="3"/>
<connect gate="G$1" pin="KEY7/GPO5" pad="2"/>
<connect gate="G$1" pin="KEY8/GPO6" pad="1"/>
<connect gate="G$1" pin="KEY9/GPO7" pad="20"/>
<connect gate="G$1" pin="MODE" pad="12"/>
<connect gate="G$1" pin="NC" pad="15"/>
<connect gate="G$1" pin="RESET" pad="14"/>
<connect gate="G$1" pin="SCL" pad="16"/>
<connect gate="G$1" pin="SDA" pad="13"/>
<connect gate="G$1" pin="VDD" pad="11"/>
<connect gate="G$1" pin="VSS" pad="10"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:4349/2"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="DATA" library="pinhead" library_urn="urn:adsk.eagle:library:325" deviceset="PINHD-1X3" device="/90" package3d_urn="urn:adsk.eagle:package:22459/2"/>
<part name="POWER" library="pinhead" library_urn="urn:adsk.eagle:library:325" deviceset="PINHD-1X2" device="/90" package3d_urn="urn:adsk.eagle:package:22437/2"/>
<part name="CLICKWHEEL" library="pinhead" library_urn="urn:adsk.eagle:library:325" deviceset="PINHD-1X3" device="/90" package3d_urn="urn:adsk.eagle:package:22459/2"/>
<part name="U$1" library="AT42QT2120" deviceset="COMMS-AT42QT2120" device="SU" package3d_urn="urn:adsk.eagle:package:30991/2"/>
<part name="RESET" library="pinhead" library_urn="urn:adsk.eagle:library:325" deviceset="PINHD-1X1" device="" package3d_urn="urn:adsk.eagle:package:22485/2"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="DATA" gate="A" x="-38.1" y="-12.7" smashed="yes" rot="MR0">
<attribute name="NAME" x="-31.75" y="-6.985" size="1.778" layer="95" rot="MR0"/>
<attribute name="VALUE" x="-31.75" y="-20.32" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="POWER" gate="G$1" x="-66.04" y="15.24" smashed="yes" rot="R180">
<attribute name="NAME" x="-59.69" y="9.525" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="-59.69" y="20.32" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="CLICKWHEEL" gate="A" x="53.34" y="-22.86" smashed="yes">
<attribute name="NAME" x="46.99" y="-17.145" size="1.778" layer="95"/>
<attribute name="VALUE" x="46.99" y="-30.48" size="1.778" layer="96"/>
</instance>
<instance part="U$1" gate="G$1" x="0" y="0" smashed="yes">
<attribute name="NAME" x="-5.08" y="33.02" size="1.778" layer="94"/>
</instance>
<instance part="RESET" gate="G$1" x="-66.04" y="27.94" smashed="yes" rot="R180">
<attribute name="NAME" x="-59.69" y="24.765" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="-59.69" y="33.02" size="1.778" layer="96" rot="R180"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="V3P3" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="VSS"/>
<wire x1="-20.32" y1="17.78" x2="-27.94" y2="17.78" width="0.1524" layer="91"/>
<label x="-30.48" y="20.32" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="POWER" gate="G$1" pin="1"/>
<wire x1="-63.5" y1="12.7" x2="-48.26" y2="12.7" width="0.1524" layer="91"/>
<label x="-48.26" y="10.16" size="1.778" layer="95"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="VDD"/>
<wire x1="-20.32" y1="12.7" x2="-27.94" y2="12.7" width="0.1524" layer="91"/>
<label x="-30.48" y="10.16" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="POWER" gate="G$1" pin="2"/>
<wire x1="-63.5" y1="15.24" x2="-48.26" y2="15.24" width="0.1524" layer="91"/>
<label x="-48.26" y="15.24" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="MODE"/>
<wire x1="-20.32" y1="-27.94" x2="-25.4" y2="-27.94" width="0.1524" layer="91"/>
<label x="-27.94" y="-33.02" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="DATA" gate="A" pin="1"/>
<wire x1="-35.56" y1="-10.16" x2="-25.4" y2="-10.16" width="0.1524" layer="91"/>
<wire x1="-25.4" y1="-10.16" x2="-25.4" y2="-7.62" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CHANGE"/>
<wire x1="-25.4" y1="-7.62" x2="-20.32" y2="-7.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="DATA" gate="A" pin="2"/>
<wire x1="-35.56" y1="-12.7" x2="-25.4" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="-25.4" y1="-12.7" x2="-25.4" y2="-17.78" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="SCL"/>
<wire x1="-25.4" y1="-17.78" x2="-20.32" y2="-17.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="KEY0"/>
<wire x1="20.32" y1="-27.94" x2="33.02" y2="-27.94" width="0.1524" layer="91"/>
<wire x1="33.02" y1="-27.94" x2="33.02" y2="-25.4" width="0.1524" layer="91"/>
<pinref part="CLICKWHEEL" gate="A" pin="3"/>
<wire x1="33.02" y1="-25.4" x2="50.8" y2="-25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="KEY1"/>
<pinref part="CLICKWHEEL" gate="A" pin="2"/>
<wire x1="20.32" y1="-22.86" x2="50.8" y2="-22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="KEY2/GPO0"/>
<wire x1="20.32" y1="-17.78" x2="33.02" y2="-17.78" width="0.1524" layer="91"/>
<wire x1="33.02" y1="-17.78" x2="33.02" y2="-20.32" width="0.1524" layer="91"/>
<pinref part="CLICKWHEEL" gate="A" pin="1"/>
<wire x1="33.02" y1="-20.32" x2="50.8" y2="-20.32" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="SDA"/>
<wire x1="-20.32" y1="-12.7" x2="-22.86" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="-22.86" y1="-12.7" x2="-22.86" y2="-15.24" width="0.1524" layer="91"/>
<pinref part="DATA" gate="A" pin="3"/>
<wire x1="-22.86" y1="-15.24" x2="-35.56" y2="-15.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="RESET" gate="G$1" pin="1"/>
<pinref part="U$1" gate="G$1" pin="RESET"/>
<wire x1="-63.5" y1="27.94" x2="-20.32" y2="27.94" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
