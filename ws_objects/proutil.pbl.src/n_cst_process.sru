$PBExportHeader$n_cst_process.sru
forward
global type n_cst_process from n_base
end type
end forward

global type n_cst_process from n_base
end type
global n_cst_process n_cst_process

type prototypes
FUNCTION BOOLEAN EnumProcesses(REF ULONG process_id[2048], ULONG array_size,REF ULONG bytes) LIBRARY "psapi.dll"
FUNCTION ULONG OpenProcess(ULONG access_flag, BOOLEAN inheritence_flag,ULONG process_id) LIBRARY "kernel32.dll"
FUNCTION BOOLEAN EnumProcessModules(ULONG process_handle, REF ULONG module_handles[2048], ULONG array_size, REF ULONG bytes) LIBRARY "psapi.dll"
FUNCTION ULONG GetModuleBaseNameW(ULONG process_handle, ULONG module_handle,REF STRING base_name, ULONG buffer_size) LIBRARY "psapi.dll"
FUNCTION BOOLEAN CloseHandle(ULONG process_handle) LIBRARY "kernel32.dll" 
end prototypes

type variables
CONSTANT LONG PROCESS_TERMINATE=1
CONSTANT LONG PROCESS_CREATE_THREAD=2
CONSTANT LONG PROCESS_SET_SESSIONID=4
CONSTANT LONG PROCESS_VM_OPERATION=8
CONSTANT LONG PROCESS_VM_READ=16
CONSTANT LONG PROCESS_VM_WRITE=32
CONSTANT LONG PROCESS_DUP_HANDLE=64
CONSTANT LONG PROCESS_CREATE_PROCESS=128
CONSTANT LONG PROCESS_SET_QUOTA=256
CONSTANT LONG PROCESS_SET_INFORMATION=512
CONSTANT LONG PROCESS_QUERY_INFORMATION=1024
CONSTANT LONG PROCESS_ALL_ACCESS=4095
CONSTANT LONG SYNCHRONIZE=1048576
end variables

forward prototypes
public function string of_get_process_name (unsignedlong aul_processid)
public function long of_get_process_id (string as_processname, ref unsignedlong aul_processidlist[])
public function integer of_get_windows_process_id_list (ref unsignedlong aul_processidarray[])
public function string of_get_process_name (unsignedlong aul_processid)
public function long of_get_process_id (string as_processname, ref unsignedlong aul_processidlist[])
public function integer of_get_windows_process_id_list (ref unsignedlong aul_processidarray[])
end prototypes

public function string of_get_process_name (unsignedlong aul_processid);// This function returns the Process Name for the specified Process ID.
ULONG lul_ProcessHandle, lul_ModuleArray[2048], lul_ArraySize=8192,lul_Bytes, lul_BufferSize=1024
ULONG lul_BufferLength
INTEGER li_Index
STRING ls_BaseName
CONSTANT ULONG PROCESS_QUERY_INFORMATION_PROCESS_VM_READ_SYNCHRONIZE=1049616

// Get process handle for specified Process ID.
lul_ProcessHandle = OpenProcess(PROCESS_QUERY_INFORMATION_PROCESS_VM_READ_SYNCHRONIZE, FALSE, aul_ProcessID)
IF IsNull(lul_ProcessHandle) THEN lul_ProcessHandle = 0

// If we have a process handle, then continue.
IF lul_ProcessHandle >= 0 THEN

 // Get the module handles for the specified process handle.
 IF EnumProcessModules(lul_ProcessHandle, lul_ModuleArray, lul_ArraySize,lul_Bytes) THEN
  li_Index = 0

  DO
   li_Index ++
   ls_BaseName = Space(lul_BufferSize)  // initialize for function call

   // Get name of process for specified handle.
   lul_BufferLength = GetModuleBaseNameW(lul_ProcessHandle,lul_ModuleArray[li_Index], ls_BaseName, lul_BufferSize)

   IF lul_BufferLength > 0 THEN
    ls_BaseName = Trim(ls_BaseName)
    RETURN ls_BaseName
   END IF
  LOOP UNTIL lul_ModuleArray[li_Index] <> 0
 END IF

 CloseHandle(lul_ProcessHandle)
END IF

RETURN '' 
end function

public function long of_get_process_id (string as_processname, ref unsignedlong aul_processidlist[]);ULONG lul_ProcessIDArray[], lul_EmptyArray[]
LONG ll_Count, ll_Index
INTEGER li_Count=0
STRING ls_ProcessName

// Initialize.
aul_ProcessIDList = lul_EmptyArray
as_ProcessName = Lower(as_ProcessName)

// Get list of Windows processes.
ll_Count = of_get_windows_process_id_list(lul_ProcessIDArray)

FOR ll_Index = 1 TO ll_Count
 ls_ProcessName = Lower(of_get_process_name(lul_ProcessIDArray[ll_Index]))
 IF as_ProcessName = ls_ProcessName THEN
  li_Count ++
  aul_ProcessIDList[li_Count] = lul_ProcessIDArray[ll_Index]
 END IF
NEXT

RETURN Upperbound(aul_ProcessIDList)

end function

public function integer of_get_windows_process_id_list (ref unsignedlong aul_processidarray[]);// This function gets the current list of Process IDs running on the system.
ULONG lul_ProcessArray[2048], lul_ArraySize=8192, lul_Bytes,lul_EmptyArray[]
LONG ll_Count, ll_Index
CONSTANT INTEGER BYTES_PER_ULONG=4

// Initialize array to be empty.
aul_ProcessIDArray = lul_EmptyArray

IF EnumProcesses(lul_ProcessArray, lul_ArraySize, lul_Bytes) THEN

 // Copy Process ID numbers from one array to another.
 ll_Count = lul_Bytes / BYTES_PER_ULONG

 FOR ll_Index = 1 TO ll_Count
  aul_ProcessIDArray[ll_Index] = lul_ProcessArray[ll_Index]
 NEXT

 RETURN Upperbound(aul_ProcessIDArray)
END IF

RETURN -1 
end function

on n_cst_process.create
call super::create
end on

on n_cst_process.destroy
call super::destroy
end on

