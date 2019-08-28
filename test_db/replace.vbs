Option Explicit
Dim fso,strFilename,strSearch,strReplace,strNewFile,objFile,oldContent,newContent,newFile
 
strFilename=WScript.Arguments.Item(0)
strSearch=WScript.Arguments.Item(1)
strReplace=WScript.Arguments.Item(2)
strNewFile=WScript.Arguments.Item(3)
 
'Does file exist?
Set fso=CreateObject("Scripting.FileSystemObject")
if fso.FileExists(strFilename)=false then
   wscript.echo "file not found!"
   wscript.Quit
end if
 
'Read file
set objFile=fso.OpenTextFile(strFilename,1)
oldContent=objFile.ReadAll
 
'Write new file
newContent=replace(oldContent,strSearch,strReplace,1,-1,0)
set newFile=fso.CreateTextFile(strNewFile,2)
newFile.Write newContent
newFile.Close 