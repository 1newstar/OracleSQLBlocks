#!/bin/ksh
RESULT_FILE_PATH=/home/mon
HEALTH_CHECK_DATE=`date "+%Y%m%d%H%M"`
HOST_NAME=`hostname`
RESULT_FILE_NAME=${RESULT_FILE_PATH}/${HOST_NAME}_${HEALTH_CHECK_DATE}_HealthCheck.log

#su - oracle
sqlplus -S dbperf/dbperf <<EOF
set heading off pagesize 0 feedback off
spool /home/mon/tmp.cfg replace
select 'export CLUSTER_DATABASE='||value from v\$parameter where name='cluster_database' ;
select 'export DB_VERSION='||substr(version,1,2) from v\$instance where rownum <2 ;
spool off
exit
EOF

chmod 777 /home/mon/tmp.cfg

sh /home/mon/tmp.cfg

echo "DB health check happened :"$HEALTH_CHECK_DATE                       >>${RESULT_FILE_NAME}
echo "==========================================================================" >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== hostname ==================================================" >>${RESULT_FILE_NAME}
hostname                                                                  >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== ifconfig -a ==========================================" >>${RESULT_FILE_NAME}
ifconfig -a                                                               >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== oslevel -s ===========================================" >>${RESULT_FILE_NAME}
oslevel -s                                                                >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== oslevel -r ===========================================" >>${RESULT_FILE_NAME}
oslevel -r                                                                >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== instfix -iv===========================================" >>${RESULT_FILE_NAME}
instfix -iv                                                               >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== lsattr -El sys0 ======================================" >>${RESULT_FILE_NAME}
lsattr -El sys0                                                           >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== locale -a ============================================" >>${RESULT_FILE_NAME}
locale -a                                                                 >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== lsdev -Cc aio ========================================" >>${RESULT_FILE_NAME}
lsdev -Cc aio                                                             >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== lsattr -El aio0 ======================================" >>${RESULT_FILE_NAME}
lsattr -El aio0                                                           >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============dlm version =========================================" >>${RESULT_FILE_NAME}
lslpp -l|grep -i dlm                                                     >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== HA version ===========================================" >>${RESULT_FILE_NAME}
lslpp -l|grep server|grep rte                                             >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== /usr/sbin/no -a |grep ipqmaxlen  =====================" >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep ipqmaxlen                                           >>${RESULT_FILE_NAME}
                                                                          
                                                                          
echo " ">>${RESULT_FILE_NAME}                                             
echo "============== /usr/sbin/no -a |grep rfc1323   ======================" >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep rfc1323                                             >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== /usr/sbin/no -a |grep sb_max   =======================" >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep sb_max                                              >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== /usr/sbin/no -a |grep tcp_recvspace   =================" >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep tcp_recvspace                                        >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== /usr/sbin/no -a |grep tcp_sendspace   =================" >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep tcp_sendspace                                        >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== /usr/sbin/no -a |grep udp_recvspace  ================="  >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep udp_recvspace                                        >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== /usr/sbin/no -a |grep udp_sendspace   =================" >>${RESULT_FILE_NAME}
/usr/sbin/no -a |grep udp_sendspace                                        >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== vmstat -v |grep maxperm   =============================" >>${RESULT_FILE_NAME}
vmstat -v |grep maxperm                                                    >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== vmstat -v |grep maxclient ============================" >>${RESULT_FILE_NAME}
vmstat -v |grep maxclient                                                  >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== vmstat -v |grep maxpin  =============================="  >>${RESULT_FILE_NAME}
vmstat -v |grep maxpin                                                     >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== vmstat -v |grep minperm   ============================" >>${RESULT_FILE_NAME}
vmstat -v |grep minperm                                                   >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== netstat -in =========================================" >>${RESULT_FILE_NAME}
netstat -in                                                               >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== netstat -rn =========================================" >>${RESULT_FILE_NAME}
netstat -rn                                                               >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== uname -a for root ====================================" >>${RESULT_FILE_NAME}
uname -a >>${RESULT_FILE_NAME}

#echo " ">>${RESULT_FILE_NAME}
#echo "============== uname -a for oracle ==================================" >>${RESULT_FILE_NAME}
#su - oracle -c "ulimit -a"                                                >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== /etc/hosts ==========================================" >>${RESULT_FILE_NAME}
cat /etc/hosts                                                            >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== lsps -a===============================================" >>${RESULT_FILE_NAME}
lsps -a                                                                   >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== lsps -s===============================================" >>${RESULT_FILE_NAME}
lsps -s                                                                   >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== df -m ===============================================" >>${RESULT_FILE_NAME}
df -m                                                                     >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== ifconfig -a ==================" >>${RESULT_FILE_NAME}
ifconfig -a >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== ps -ef|grep ntp|grep -v ===============================" >>${RESULT_FILE_NAME}
ps -ef|grep ntp|grep -v                                                     >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============== ntpq -p ===============================================" >>${RESULT_FILE_NAME}
ntpq -p                                                                     >>${RESULT_FILE_NAME}
lssrc -a|grep ntp                                                           >>${RESULT_FILE_NAME}


echo " ">>${RESULT_FILE_NAME}
echo "============== vmstat -v ==============================================" >>${RESULT_FILE_NAME}
vmstat -v                                                                    >>${RESULT_FILE_NAME}
                                                                           
echo " ">>${RESULT_FILE_NAME}                                              
echo "============== vmstat 1 10 ============================================" >>${RESULT_FILE_NAME}
vmstat 1 10                                                                  >>${RESULT_FILE_NAME}
                                                                           
echo " ">>${RESULT_FILE_NAME}                                              
echo "============== iostat 1 10 ============================================" >>${RESULT_FILE_NAME}
iostat 1 10                                                                  >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}                                              
echo "============== mpstat 1 10 ============================================" >>${RESULT_FILE_NAME}
mpstat 1 10

echo " ">>${RESULT_FILE_NAME}                                              
echo "============== sar 1 10  ==============================================" >>${RESULT_FILE_NAME}
sar 1 10                                                                     >>${RESULT_FILE_NAME}

if [ "${CLUSTER_DATABASE}" == "Y" ];then
		echo " ">>${RESULT_FILE_NAME}                                             
		echo "============== ps -ef |grep init ==================================" >>${RESULT_FILE_NAME}
		ps -ef |grep init                                                        >>${RESULT_FILE_NAME}  
		
		echo " ">>${RESULT_FILE_NAME}                                             
		echo "============== ps -ef |grep d.bin =================================" >>${RESULT_FILE_NAME}
		ps -ef |grep d.bin                                                       >>${RESULT_FILE_NAME} 

		echo " ">>${RESULT_FILE_NAME}
		echo "============== ocr position========================================" >>${RESULT_FILE_NAME} 
		cat /etc/oracle/ocr.loc                                                  >>${RESULT_FILE_NAME} 

		
		#if [ "${DB_VERSION}" == "11" ]; then
		#    su - grid
		#    echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "============== Grid owner's pfole =============================" >>${RESULT_FILE_NAME}
		#    cat .profile                                                         >>${RESULT_FILE_NAME}                
		#    
		#    
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "============== crsctl check crs ===============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl check crs                                      >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "============== crsctl check cssd ==============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl check cssd                                     >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "============== crsctl check crsd ==============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl check crsd                                     >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "============== crsctl check crsd ==============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl check evmd                                     >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "=============oifcfg getif ===================================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/oifcfg getif                                          >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "=============ocrcheck =======================================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/ocrcheck                                              >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "=============votedisk position ==============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl query css votedisk                             >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "=============votedisk position ==============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl query css softwareversion                      >>${RESULT_FILE_NAME}
		#		                                                                                          
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "=============votedisk position ==============================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/crsctl query css activeversion                        >>${RESULT_FILE_NAME}
    #
		#		echo " ">>${RESULT_FILE_NAME}                                                             
		#		echo "=============srvctl config nodeapps ==========================" >>${RESULT_FILE_NAME}
		#		${GI_HOME}/bin/srvctl config nodeapps -n ${HOST_NAME}                 >>${RESULT_FILE_NAME}
		#		
		#		exit
		#
		#fi
		
		if [ "${DB_VERSION}" == "10" ];then
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============crsctl check crs ===============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl check crs                                 >>${RESULT_FILE_NAME} 
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============crsctl check cssd ==============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl check cssd                                >>${RESULT_FILE_NAME} 
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============crsctl check crsd ==============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl check crsd                                >>${RESULT_FILE_NAME}
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============crsctl check crsd ==============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl check evmd                                >>${RESULT_FILE_NAME}
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============oifcfg getif ===================================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/oifcfg getif                                     >>${RESULT_FILE_NAME} 
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============ocrcheck =======================================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/ocrcheck                                         >>${RESULT_FILE_NAME} 		
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============votedisk position ==============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl query css votedisk                        >>${RESULT_FILE_NAME} 
				
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============votedisk position ==============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl query css softwareversion                 >>${RESULT_FILE_NAME} 
				
				echo " ">>${RESULT_FILE_NAME}
				echo "=============votedisk position ==============================" >>${RESULT_FILE_NAME} 
				${ORA_CRS_HOME}/bin/crsctl query css activeversion                   >>${RESULT_FILE_NAME} 

				echo " ">>${RESULT_FILE_NAME}                                                             
				echo "=============srvctl config nodeapps ==========================" >>${RESULT_FILE_NAME}
				${GI_HOME}/bin/srvctl config nodeapps -n ${HOST_NAME}                 >>${RESULT_FILE_NAME}
		
				fi
fi

#su - ${ORACLE_OWNER}
#cd ~

echo " ">>${RESULT_FILE_NAME}
echo "============= ORACLE OWNER'S profile ===============================" >>${RESULT_FILE_NAME} 
cat .profile                                                                >>${RESULT_FILE_NAME}

echo " ">>${RESULT_FILE_NAME}
echo "============= ORACLE OWNER'S env ===================================" >>${RESULT_FILE_NAME} 
env                                                                         >>${RESULT_FILE_NAME}

#echo " ">>${RESULT_FILE_NAME}
#echo "============= PATCH FOR CRS HOME ===================================" >>${RESULT_FILE_NAME} 
#opatch lsinventory -oh ${ORA_CRS_HOME}                                      >>${RESULT_FILE_NAME}  
#
#echo " ">>${RESULT_FILE_NAME}
#echo "============= PATCH FOR ORACLE HOME ================================" >>${RESULT_FILE_NAME} 
#opatch lsinventory -oh ${ORACLE_HOME}


sqlplus -S dbperf/dbperf << EOF
SET NEWPAGE NONE LINESIZE 2000 TRIMSPOOL ON TERMOUT OFF
whenever sqlerror continue;
alter session set nls_date_format='YYYYMMDD HH24:MI:SS' ;
col comp_name          format a40
col version            format a20
col status             foramt a12
col modi_time          format a24
col act_time           format a24
col action             format a24
col file_name          format a60
col owner              format a16
col object_name        format a36
col object_type        format a18
col table_name         format a36
col tablespace_name    format a36
col index_name         format a36
col TRIGGER_NAME       format a36
col ACTUAL_START_DATE  format a20
col begin_time         format a24
col end_time           format a24
col DAY                format a10
col H00                format 99
col H01                format 99
col H02                format 99
col H03                format 99
col H04                format 99
col H05                format 99
col H06                format 99
col H07                format 99
col H08                format 99
col H09                format 99
col H10                format 99
col H11                format 99
col H12                format 99
col H13                format 99
col H14                format 99
col H15                format 99
col H16                format 99
col H17                format 99
col H18                format 99
col H19                format 99
col H20                format 99
col H21                format 99
col H22                format 99
col H23                format 99


spool ${RESULT_FILE_NAME} append

prompt ============DB VERSION================================
select banner from v\$version;

prompt
prompt ============DBA_REGISTRY==============================
select comp_name,
       version,
       status,
       to_char(modified,'yyyy-mm-dd hh24:mi:ss') as modi_time
  from dba_registry 
  order by 1,4;

prompt
prompt ============DBA_REGISTRY================
select to_char(action_time,'yyyy-mm-dd hh24:mi:ss') as act_time,
       action,
       version
  from REGISTRY\$HISTORY;

prompt
prompt ============DBA_REGISTRY HISTORY================
select *
  from DBA_REGISTRY_HISTORY;  


prompt 
prompt ==============DATABASE OVERVIEW=======================


COLUMN database_name      FORMAT a15    HEADING 'DB Name'          
COLUMN dbid                             HEADING 'Database ID'            
COLUMN creation_date      FORMAT a10    HEADING 'Creat Date'          
COLUMN log_mode                         HEADING 'Log Mode'               
COLUMN open_mode                        HEADING 'Open Mode'              
COLUMN force_logging      FORMAT A10    HEADING 'Force Log'          
COLUMN controlfile_type   FORMAT A13    HEADING 'Controlfile'       
SELECT name                             database_name
      ,TO_CHAR(created, 'YYYY-MM-DD')   creation_date
      ,log_mode                         log_mode
      ,flashback_on                     flashback_on
      ,open_mode                        open_mode
      ,force_logging                    force_logging
      ,controlfile_type                 controlfile_type
      ,database_role
      ,switchover_status 
FROM v\$database;


prompt ==============INSTANCE OVERVIEW=======================
prompt 

COLUMN instance_name       FORMAT a10    HEADING 'Instance|Name'       
COLUMN instance_number     FORMAT a10    HEADING 'Instance|Number'     
COLUMN host_name_print     FORMAT a15    HEADING 'Host|Name'           
COLUMN oracle_version                    HEADING 'Oracle|Version'      
COLUMN start_time          FORMAT a20    HEADING 'Start|Time'          
COLUMN uptime                            HEADING 'Uptime|(in days)'    
COLUMN parallel            FORMAT a8     HEADING 'RAC?'                
COLUMN status              FORMAT a10    HEADING 'Instance|Status'     
COLUMN logins              FORMAT a10    HEADING 'Logins'              
COLUMN archiver            FORMAT a10    HEADING 'Archiver'  
          
SELECT
    instance_name                                    instance_name
  , to_char(instance_number)                         instance_number
  , host_name                                        host_name_print
  , version                                          oracle_version
  , TO_CHAR(startup_time,'mm/dd/yyyy HH24:MI:SS')    start_time
  , ROUND(TO_CHAR(SYSDATE-startup_time), 2)          uptime
  , parallel                                         parallel
  , status                                           status
  , logins                                           logins
  , DECODE(   archiver
            , 'FAILED'
            , archiver
            , archiver )                             archiver
FROM v\$instance
ORDER BY instance_number;


prompt
prompt ============ SGA INFO =====================================================
select name,
       round(bytes/1024/1024,2) as size_mb,
       resizeable 
  from v\$sgainfo ;

prompt
prompt ============ Tablespace over view =========================================

SELECT TABLESPACE_NAME,
       NEXT_EXTENT,
       EXTENT_MANAGEMENT,
       ALLOCATION_TYPE,
       SEGMENT_SPACE_MANAGEMENT 
  FROM DBA_TABLESPACES;

prompt
prompt =========== PGA stat =====================================================
select name,
      value
  from v\$pgastat;
 where value > 0;
 
prompt
prompt ============Dead Process =================================================
select spid,
        pid,
        terminal,
        program
 from v\$process 
where pid <>  1
  and addr in (select addr from v\$process where pid <> 1 minus select paddr from v\$session  );


prompt                                         
prompt ============USER with DBA privilege ======================================
select * from dba_role_privs where granted_role = 'DBA' AND GRANTEE NOT IN ('SYS','SYSTEM') ;

prompt                                         
prompt ============USER with SYSDBA privilege ==================================
select * from v\$pwfile_users ;

prompt                                         
prompt ============Invalid data or temp files===========
select file_name,status from dba_data_files where status='INVALID'
union
select name,status from v\$datafile where status Not In('SYSTEM','ONLINE');

prompt                                         
prompt ============Invalid Objects==============
select owner,
       object_name,
       object_type,
       status
  from dba_objects
 where status <> 'VALID';
 
prompt                                         
prompt ============Tables In System tablespace===
select OWNER,
       TABLE_NAME,
       TABLESPACE_NAME,
       NUM_ROWS 
  from dba_tables 
 where tablespace_name='SYSTEM'
   AND  OWNER NOT IN ('SYS','SYSTEM','OUTLN','WMSYS','ORDSYS',
                      'MDSYS','SCOTT','OLAPSYS','ORDDATA',
                      'MGMT_VIEW','DBSNMP','FLOWS_FILES');

prompt                                         
prompt ============Indexes In System tablespace==========
select OWNER,
      INDEX_NAME,
      INDEX_TYPE,
      TABLE_NAME
 from dba_INDEXES
where tablespace_name='SYSTEM' 
  AND  OWNER NOT IN ('SYS','SYSTEM','OUTLN','WMSYS','ORDSYS',
                      'MDSYS','SCOTT','OLAPSYS','ORDDATA',
                      'MGMT_VIEW','DBSNMP','FLOWS_FILES');
                     
prompt                                         
prompt ============APPUSER'S DEFULE TABLESPACE IN SYSTEM===
SELECT USERNAME,
       DEFAULT_TABLESPACE,
       TEMPORARY_TABLESPACE,
       ACCOUNT_STATUS
  FROM DBA_USERS
 WHERE ACCOUNT_STATUS = 'OPEN'
   AND USERNAME NOT IN ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA')
   AND (DEFAULT_TABLESPACE='SYSTEM' OR TEMPORARY_TABLESPACE = 'SYSTEM');

prompt                                         
prompt ============Autoextend datafile and tempfile ===                  
select file_name,tablespace_name,autoextensible
  from dba_data_files 
  where autoextensible = 'YES'
union
select file_name,tablespace_name,autoextensible
  from dba_temp_files 
  where autoextensible = 'YES'
;       
prompt                                         
prompt ============Index with blevel >= 3 =============  
select owner,
       index_name,
       table_owner,
       table_name,
       tablespace_name,
       blevel,
       num_rows
  from dba_indexes
 where blevel >= 3 ;
 
prompt                                         
prompt ============Unable indexes =====================
SELECT OWNER,
       INDEX_NAME,
       INDEX_TYPE,
       TABLE_NAME,
       STATUS 
  FROM DBA_INDEXES 
WHERE STATUS = 'UNUSABLE';

prompt                                         
prompt ============Unable partitioned indexes =========
SELECT INDEX_NAME,
       PARTITION_NAME,
       TABLESPACE_NAME,
       STATUS 
  FROM DBA_IND_PARTITIONS
WHERE STATUS = 'UNUSABLE' ;  

prompt                                                 
prompt ============Unable subpartition indexes =========
SELECT INDEX_OWNER,
       INDEX_NAME,
       partition_name,
       subpartition_name
  FROM dba_ind_subpartitions 
 WHERE status<>'USABLE' ;
prompt                                         
prompt ============Disabled triggers ==================
SELECT OWNER,
       TABLE_NAME,
       TRIGGER_NAME,
       STATUS
  FROM DBA_TRIGGERS
 WHERE STATUS ='DISABLED';  
 
prompt                                         
prompt ============Disabled constraints ================
SELECT OWNER,
       CONSTRAINT_NAME,
       CONSTRAINT_TYPE,
       TABLE_NAME
       STATUS
   FROM DBA_CONSTRAINTS; 
  WEHRE STATUS = 'DISABLED' ;
  
prompt                                         
prompt ============REDO LOG GROUP ================ 
SELECT THREAD#,
       GROUP#,
       ROUND(BYTES/1024/1240,2) AS SIZE_MB ,
       MEMBERS
  FROM V\$LOG
 ORDER BY 1,2 ;

prompt                                         
prompt ============Some important value from sysstat ================== 
SELECT NAME,
       VALUE
FROM V\$SYSSTAT
WHERE upper(NAME) = 'REDO BUFFER ALLOCATION RETRIES'
   Or name in ('redo log space requests',
          'redo entries',
          'redo log switch interrupts',
          'user commits',
          'user rollbacks',
          'user calls',
          'sorts (rows)',
          'sorts (disk)',
          'sorts (memory)',
          'table fetch continued row',
          'table scans (short tables)',
          'table scans (long tables)',
          'workarea executions - optimal',
          'workarea executions - onepass',
          'workarea executions - multipass'); 
   
prompt                                         
prompt ============redo log buffer Retry Ratio ============ 
select retries.value/entries.value "redo log buffer Retry Ratio"
  from v\$sysstat retries,
       v\$sysstat entries
where retries.name='redo buffer allocation retries' 
  and entries.name='redo entries';

prompt 
prompt ===========Redo Log Switch Too Frequent ================
select thread#,
       sequence#,
       first_time,
       minutes
from (
select thread#,
       sequence#,
       to_char(first_time, 'yyyy-mm-dd hh24:mi:ss') first_time,
       round((first_time - lag(first_time) over(partition by thread# order by first_time)) * 24 * 60,2) minutes
  from v\$log_history
 where first_time > sysdate - 1
 order by thread#, first_time )
 where minutes <=2 ;
 
prompt 
prompt ===========Log Switch PER HOUR ==================== 

SELECT
  THREAD#
  ,SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH:MI:SS'),1,5)   DAY
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'00',1,0)) H00
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'01',1,0)) H01
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'02',1,0)) H02
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'03',1,0)) H03
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'04',1,0)) H04
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'05',1,0)) H05
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'06',1,0)) H06
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'07',1,0)) H07
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'08',1,0)) H08
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'09',1,0)) H09
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'10',1,0)) H10
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'11',1,0)) H11
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'12',1,0)) H12
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'13',1,0)) H13
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'14',1,0)) H14
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'15',1,0)) H15
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'16',1,0)) H16
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'17',1,0)) H17
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'18',1,0)) H18
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'19',1,0)) H19
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'20',1,0)) H20
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'21',1,0)) H21
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'22',1,0)) H22
  , SUM(DECODE(SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH24:MI:SS'),10,2),'23',1,0)) H23
  , COUNT(*)                                                                    TOTAL
FROM
  v\$log_history  a
where a.first_time>=sysdate-15
GROUP BY THREAD#, SUBSTR(TO_CHAR(first_time, 'MM/DD/RR HH:MI:SS'),1,5)
ORDER BY 1,2
; 
prompt 
prompt ===========SGA USAGE MAY CAUSE 4031 OR LIBRARY CACHE PIN===================
select round(small_free / all_free, 2) * 100 perc, small_free, all_free
  from (select sum(KSMCHSIZ) small_free
          from x\$ksmsp
         where KSMCHSIZ < 4400
           and KSMCHCLS = 'free') A,
       (select bytes all_free
          from v\$sgastat
         where name = 'free memory'
           and pool = 'shared pool') B;
PROMPT
select round(small_free/all_size,2)*100  perc_600 , 
small_free small_chk_count, all_size  all_chk_count                         
from (                                                            
select count(*) small_free                                   
from x\$ksmsp                                                      
where KSMCHSIZ<600                                               
) A,                                           
(select  count(*) all_size                                   
from x\$ksmsp ) B;
PROMPT
select round(small_free/all_size,2)*100  perc_4000 , 
small_free medium_chk_count, all_size  all_chk_count                         
from (                                                            
select count(*) small_free                                   
from x\$ksmsp                                                      
where KSMCHSIZ<4000                                               
) A,                                           
(select  count(*) all_size                                   
from x\$ksmsp ) B;
 

SELECT  request_failures,
        last_failure_size,
        ABORTED_REQUEST_THRESHOLD,
        ABORTED_REQUESTS,
        LAST_ABORTED_SIZE
FROM v\$shared_pool_reserved;

column kghlurcr heading "RECURRENT|CHUNKS"
column kghlutrn heading "TRANSIENT|CHUNKS"
column kghlufsh heading "FLUSHED|CHUNKS"
column kghluops heading "PINS AND|RELEASES"
column kghlunfu heading "ORA-4031|ERRORS"
column kghlunfs heading "LAST ERROR|SIZE"
column kghlushrpool heading "SUBPOOL"   

select inst_id,
      userenv('Instance') my_instid,
      kghlurcr, 
      kghlutrn, 
      kghlufsh, 
      kghluops, 
      kghlunfu, 
      kghlunfs 
from sys.x\$kghlu 
order by kghlunfu desc
; 

PROMPT
prompt COLUMN   DESCRIPTION 
prompt KSMLRCOM allocation comment that describes the type of allocation. 
prompt KSMLRSIZ amount of contiguous memory being allocated. Values over around 5K start
prompt          to be a problem, values over 10K are a serious problem, and values over
prompt          20K are very serious problems. Anything less then 5K should not be a
prompt          problem 
prompt KSMLRNUM number of objects that were flushed from the shared pool in order allocate
prompt          the memory 
prompt KSMLRHON the name of the object being loaded into the shared pool if the object is
prompt          a PL/SQL object or a cursor. 


PROMPT
Select KSMLRCOM,
       KSMLRHON,
       KSMLRNUM, 
       KSMLRSIZ 
  From x\$ksmlru 
 where KSMLRSIZ > 5000;


PROMPT
prompt  "----------BUFFER RATIO-------------" 

select 'buffer ratio:' RIO,
	     round(((sum(decode(name,'consistent gets',value,0))+
	     Sum(decode(name,'db block gets',value,0))-
	     sum(decode(name,'physical reads',value,0)))/
	     (sum(decode(name,'consistent gets',value,0))+
	     Sum(decode(name,'db block gets',value,0))))*100,2) Hitratio
from V\$sysstat;

PROMPT
prompt  "----------LIB RATIO-------------" 
select 'lib ratio:' RIO,
round(Sum(pins)/(sum(pins)+sum(reloads))*100,2) "percentage"
from v\$librarycache;

PROMPT
PROMPT =============Abnormal Jobs ===========================
select job,
       schema_user,
       to_char(last_date,'yyyy-mm-dd hh24:mi:ss') last_date,
       to_char(next_date,'yyyy-mm-dd hh24:mi:ss') last_date,
       status
  from dba_jobs
WHERE broken = 'Y'
  AND failures > 0
;

prompt 
prompt ========== FK without INDEX-------------" 
select owner,table_name, constraint_name
      ,cname1 
       || nvl2(cname2, ', ' || cname2, null)
       || nvl2(cname3, ', ' || cname3, null)
       || nvl2(cname4, ', ' || cname4, null)
       || nvl2(cname5, ', ' || cname5, null)
       || nvl2(cname6, ', ' || cname6, null)
       || nvl2(cname7, ', ' || cname7, null)
       || nvl2(cname8, ', ' || cname8, null) as cols
from (
select a.owner,b.table_name, b.constraint_name
      ,max(decode(a.position, 1, a.column_name, null)) as cname1
      ,max(decode(a.position, 2, a.column_name, null)) as cname2
      ,max(decode(a.position, 3, a.column_name, null)) as cname3
      ,max(decode(a.position, 4, a.column_name, null)) as cname4
      ,max(decode(a.position, 5, a.column_name, null)) as cname5
      ,max(decode(a.position, 6, a.column_name, null)) as cname6
      ,max(decode(a.position, 7, a.column_name, null)) as cname7
      ,max(decode(a.position, 8, a.column_name, null)) as cname8
      ,count(*) as col_cnt
from dba_cons_columns  a,
      dba_constraints b
where a.constraint_name = b.constraint_name
and   b.constraint_type = 'R'
and a.owner = b.owner
and a.owner NOT IN
       ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA')
group by b.table_name, b.constraint_name,a.owner
) cons
where col_cnt > all
      (
      select count(*)
      from dba_ind_columns i
      where i.table_name = cons.table_name
      and   i.column_name in(cname1, cname2, cname3, cname4, cname5, cname6, cname7, cname8)
      and   i.column_position <= cons.col_cnt
      and i.index_owner=cons.owner
      group by i.index_name
      );

prompt
prompt  ========= PARALLEL TABLES ==============================================
 SELECT   OWNER, 
          TABLE_NAME,
          PARTITIONED,
          degree
  FROM   DBA_TABLES
 WHERE   owner NOT IN
       ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA')
         AND (DEGREE > '1' );

prompt
prompt  ========= PARALLEL INDEXES ============================================= 
 SELECT   OWNER, 
          TABLE_NAME,
          index_name,degree
  FROM   DBA_indexes
 WHERE   owner NOT IN
       ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA')
         AND (DEGREE > '1' );

prompt
prompt  ===============INDEX and Table In then SAME TABLESPACE==================
SELECT  b.owner, b.table_name table_name,a.index_name index_name, b.tablespace_name 
  FROM    dba_indexes a, dba_tables b
  WHERE   a.table_owner = b.owner
AND       a.table_name = b.table_name
AND       a.tablespace_name = b.tablespace_name
AND       b.owner NOT IN
       ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA')
         ;
prompt 
prompt  ===========INDEX LOW SELECTION =========================================
select owner ,table_name,index_name,num_rows,distinct_keys ,distinct_keys / (num_rows+1) selection
from dba_indexes where distinct_keys / (num_rows+1) < 0.2 
and num_rows > 500000 
and owner NOT IN ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA') 
order by distinct_keys / (num_rows+1) desc;

prompt 
prompt  =============TOO MUCH INDEX COLUMNS (>5)================================
SELECT a.index_owner, 
       a.table_name,
       a.index_name,
       COUNT(*) column_count
 FROM  dba_ind_columns a
WHERE  a.index_owner NOT IN
       ('SYSTEM', 'SYS', 'OLAPSYS', 'SI_INFORMTN_SCHEMA', 'MGMT_VIEW',
        'ORDPLUGINS', 'TSMSYS', 'XDB', 'SYSMAN', 'WMSYS', 'SCOTT', 'DBSNMP',
        'DMSYS', 'DIP', 'OUTLN', 'EXFSYS', 'ANONYMOUS', 'CTXSYS', 'ORDSYS',
        'MDSYS', 'MDDATA')
GROUP BY  a.index_owner,
          a.table_name,
          a.index_name
HAVING    COUNT(*) > 5
ORDER by  column_count desc
;

prompt 
prompt ===========STATISTICS AUTO COLLECT ======================================
SELECT TO_CHAR(ACTUAL_START_DATE,'YYYY-MM-DD HH24:MI') AS ACTUAL_START_DATE,
       RUN_DURATION,
       STATUS
 FROM dba_scheduler_job_run_details 
where job_name ='GATHER_STATS_JOB'
  and ACTUAL_START_DATE >= sysdate - 15
ORDER BY 1;
 
prompt
prompt ===========ASM DISKGROUP ================================================ 
select name,
       total_mb,
       free_mb,
       allocation_unit_size,
       round(free_mb/total_mb,2)*100 as free_pct,
       state
from v\$asm_diskgroup
; 
 

prompt
prompt =========== sql_area_histpgram ==========================================
SELECT LOW_OPTIMAL_SIZE/1024 low_kb,
       (HIGH_OPTIMAL_SIZE+1)/1024 high_kb,
       OPTIMAL_EXECUTIONS,
       ONEPASS_EXECUTIONS,
       MULTIPASSES_EXECUTIONS,
       TOTAL_EXECUTIONS
FROM v\$SQL_WORKAREA_HISTOGRAM
WHERE TOTAL_EXECUTIONS > 0;
 
PROMPT
prompt ========== value from dba_hist_sysmetric_summary =======================
select INSTANCE_NUMBER,
       TO_CHAR(begin_time,'YYYY-MM-DD HH24:MI:SS') BEGIN_TIME,
       TO_CHAR(end_time,'YYYY-MM-DD HH24:MI:SS') END_TIME,
       metric_name,round(maxval,2) AS MAX_VALUE,
       round(minval,2) MIN_VALUE,
       round(average) AVER_VALUE
 from dba_hist_sysmetric_summary 
where metric_name in (
'Database CPU Time Ratio',
'Database Wait Time Ratio',
'User Transaction Per Sec',
'Response Time Per Txn',
'Buffer Cache Hit Ratio',
'Library Cache Miss Ratio',
'Row Cache Hit Ratio',
'Memory Sorts Ratio',
'Logical Reads Per Sec',
'Physical Reads Per Sec',
'Physical Writes Per Sec',
'GC Current Block Received Per Second',
'GC CR Block Received Per Second'
) 
and begin_time > sysdate - 7
and instance_number=SYS_CONTEXT('USERENV','INSTANCE')
order by INSTANCE_NUMBER, metric_name,begin_time; 

prompt
prompt ======== system parameters =====================================
select name,value from v\$parameter ;

prompt
prompt ======== system NLS parameters =====================================
select PARAMETER,value from v\$NLS_parameters ;
 
spool off
exit
EOF

#su - oracle
rman target / nocatalog <<EOF >> ${RESULT_FILE_NAME}
show all;
exit
EOF
exit



