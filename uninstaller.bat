@ECHO OFF
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""c:\temp\scripts\uninstall.ps1""' -Verb RunAs}"
