Option Explicit
Dim fso,strFilename,strSearch,strReplace,objFile,oldContent,newContent
 
strFilename=WScript.Arguments.Item(0)
strSearch=WScript.Arguments.Item(1)
strReplace=WScript.Arguments.Item(2)
 
'Does file exist?
Set fso=CreateObject("Scripting.FileSystemObject")
if fso.FileExists(strFilename)=false then
   wscript.echo "file not found!"
   wscript.Quit
end if
 
'Read file
set objFile=fso.OpenTextFile(strFilename,1)
oldContent=objFile.ReadAll
 
'Write file
newContent=replace(oldContent,strSearch,strReplace,1,-1,0)
set objFile=fso.OpenTextFile(strFilename,2)
objFile.Write newContent
objFile.Close