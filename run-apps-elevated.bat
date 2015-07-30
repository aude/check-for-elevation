@echo off

REM Runs configured apps elevated.

REM ------------ Copyright ------------
REM -----------------------------------
REM Copyright (C) 2014-toyear  aude
REM
REM This program is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.
REM
REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with this program.  If not, see <http://www.gnu.org/licenses/>.


REM Variable containing apps to run elevated. Should be on the form: Paths to executables, separated by commas (["]path["],["]path["],...).
set apps=
REM Also, append parameters, and expect them to be app paths.
set apps=%apps%,%*
REM Path to "elevate.exe".
set elevateexe="C:\PA\elevate\bin.x86-64\elevate.exe"

REM Check for elevation.
REM Try initiate app that requires elevation. Will fail if not admin, will display available commands if admin (but do not display these).
REM ~https://stackoverflow.com/a/21295806
fsutil dirty query %systemdrive% >NUL
REM If app did not return successfully, batch must be elevated.
if %errorlevel% neq 0 (
	echo.
	REM Initiate an elevated process of this batch, with appended current command line switches.
	%elevateexe% %0 %*
	goto :eof
)

REM Loop through apps in variable. Should be on the form (["]path["],["]path["],...).
for %%a in (%apps%) do (
	REM If not empty string, to prevent command line launching.
	if "%%a" neq "" (
		start "" %%a
	)
)
