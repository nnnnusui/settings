@echo off
echo Clean up disk and create system partition.

(echo list disk) | diskpart
set /P DiskNum=Plz select disk: 
set /P Size=Plz System-partition size(MiB): 

(echo select disk %DiskNum%
 echo list disk            ) | diskpart

set /P Answer=Disk %DiskNum% will be cleaned. Are you ready?[y/n]: 
if /i {%Answer%}=={y}   (goto :yes)
if /i {%Answer%}=={yes} (goto :yes)
goto :exit


:yes
(
echo select disk %DiskNum%
echo clean
echo convert gpt

echo create partition efi size=100
echo format quick fs=fat32 label="System"
echo assign letter="S"

echo create partition msr size=16

echo create partition primary size=%Size%
echo format quick fs=ntfs label="Windows"
echo assign letter="W"

echo create partition primary size=500
echo format quick fs=ntfs label="Recovery tools"
echo assign letter="R"
echo set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"
echo gpt attributes=0x8000000000000001

echo list volume
) | diskpart


:exit
echo end.
pause
