<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="12008004">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Fastrak" Type="Folder">
			<Item Name="Setup" Type="Folder">
				<Item Name="OutputList2Info.vi" Type="VI" URL="../SubVIs/OutputList2Info.vi"/>
				<Item Name="PolInit.vi" Type="VI" URL="../SubVIs/PolInit.vi"/>
				<Item Name="PolConfig.vi" Type="VI" URL="../PolConfig.vi"/>
				<Item Name="PolByteInfo.vi" Type="VI" URL="../SubVIs/PolByteInfo.vi"/>
			</Item>
			<Item Name="Collect" Type="Folder">
				<Item Name="PolStart-C.vi" Type="VI" URL="../SubVIs/PolStart-C.vi"/>
				<Item Name="PolRead-C.vi" Type="VI" URL="../SubVIs/PolRead-C.vi"/>
				<Item Name="PolStop-C.vi" Type="VI" URL="../SubVIs/PolStop-C.vi"/>
			</Item>
			<Item Name="Interpret" Type="Folder">
				<Item Name="PolInterpret.vi" Type="VI" URL="../SubVIs/PolInterpret.vi"/>
				<Item Name="PolXYGraph.vi" Type="VI" URL="../SubVIs/PolXYGraph.vi"/>
			</Item>
			<Item Name="PolhemusDataCollect.vi" Type="VI" URL="../PolhemusDataCollect.vi"/>
		</Item>
		<Item Name="CyberGlove" Type="Folder">
			<Item Name="Calibrate" Type="Folder">
				<Item Name="CalDataSave.vi" Type="VI" URL="../Cyberglove SubVIs/CalDataSave.vi"/>
				<Item Name="CgCalibrate.vi" Type="VI" URL="../CgCalibrate.vi"/>
				<Item Name="HCalSet.vi" Type="VI" URL="../Cyberglove SubVIs/Hardware/HCalSet.vi"/>
				<Item Name="HCalGlove.vi" Type="VI" URL="../Cyberglove SubVIs/Hardware/HCalGlove.vi"/>
				<Item Name="HCalFile.vi" Type="VI" URL="../Cyberglove SubVIs/Hardware/HCalFile.vi"/>
				<Item Name="HCalGet.vi" Type="VI" URL="../Cyberglove SubVIs/Hardware/HCalGet.vi"/>
			</Item>
			<Item Name="Setup" Type="Folder">
				<Item Name="ButtonWait.vi" Type="VI" URL="../Cyberglove SubVIs/ButtonWait.vi"/>
				<Item Name="Light321.vi" Type="VI" URL="../Cyberglove SubVIs/Light321.vi"/>
				<Item Name="CgLight.vi" Type="VI" URL="../Cyberglove SubVIs/CgLight.vi"/>
				<Item Name="CgInfo.vi" Type="VI" URL="../Cyberglove SubVIs/CgInfo.vi"/>
				<Item Name="CalFile2Info.vi" Type="VI" URL="../Cyberglove SubVIs/CalFile2Info.vi"/>
				<Item Name="CgInit.vi" Type="VI" URL="../Cyberglove SubVIs/CgInit.vi"/>
				<Item Name="CustomMask.vi" Type="VI" URL="../Cyberglove SubVIs/CustomMask.vi"/>
			</Item>
			<Item Name="Collect" Type="Folder">
				<Item Name="CgStart.vi" Type="VI" URL="../Cyberglove SubVIs/CgStart.vi"/>
				<Item Name="CgRead.vi" Type="VI" URL="../Cyberglove SubVIs/CgRead.vi"/>
				<Item Name="CgStop.vi" Type="VI" URL="../Cyberglove SubVIs/CgStop.vi"/>
			</Item>
			<Item Name="Interpret" Type="Folder">
				<Item Name="CgRawInterp.vi" Type="VI" URL="../Cyberglove SubVIs/CgRawInterp.vi"/>
				<Item Name="Raw2Angle.vi" Type="VI" URL="../Cyberglove SubVIs/Raw2Angle.vi"/>
				<Item Name="AngularChange.vi" Type="VI" URL="../Cyberglove SubVIs/AngularChange.vi"/>
			</Item>
			<Item Name="CgHandShapes.vi" Type="VI" URL="../CgHandShapes.vi"/>
			<Item Name="CgDataCollect.vi" Type="VI" URL="../CgDataCollect.vi"/>
		</Item>
		<Item Name="DataCollect.vi" Type="VI" URL="../DataCollect.vi"/>
		<Item Name="BaudRateSelector.ctl" Type="VI" URL="../BaudRateSelector.ctl"/>
		<Item Name="Subject2Path.vi" Type="VI" URL="../Subject2Path.vi"/>
		<Item Name="FileEnumerator.vi" Type="VI" URL="../FileEnumerator.vi"/>
		<Item Name="PolhemusTesting.vi" Type="VI" URL="../SubVIs/PolhemusTesting.vi"/>
		<Item Name="GlobalVariables.vi" Type="VI" URL="../GlobalVariables.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="VISA Configure Serial Port (Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Instr).vi"/>
				<Item Name="VISA Configure Serial Port (Serial Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Serial Instr).vi"/>
				<Item Name="VISA Configure Serial Port" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port"/>
				<Item Name="Select Event Type.ctl" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/Select Event Type.ctl"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="NI_AALPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALPro.lvlib"/>
				<Item Name="Read From Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File.vi"/>
				<Item Name="Read From Spreadsheet File (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (DBL).vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Read From Spreadsheet File (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (I64).vi"/>
				<Item Name="Read From Spreadsheet File (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (string).vi"/>
				<Item Name="Write To Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File.vi"/>
				<Item Name="Write To Spreadsheet File (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File (DBL).vi"/>
				<Item Name="Write To Spreadsheet File (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File (I64).vi"/>
				<Item Name="Write To Spreadsheet File (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File (string).vi"/>
				<Item Name="Acquire Input Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Acquire Input Data.vi"/>
				<Item Name="joystickAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/joystickAcquire.vi"/>
				<Item Name="keyboardAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/keyboardAcquire.vi"/>
				<Item Name="mouseAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/mouseAcquire.vi"/>
				<Item Name="Intialize Keyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Intialize Keyboard.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Space Constant.vi" Type="VI" URL="/&lt;vilib&gt;/dlg_ctls.llb/Space Constant.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="General Error Handler CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler CORE.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Write Spreadsheet String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Spreadsheet String.vi"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
			</Item>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="XDNodeRunTimeDep.lvlib" Type="Library" URL="/&lt;vilib&gt;/Platform/TimedLoop/XDataNode/XDNodeRunTimeDep.lvlib"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
