
col filename format a30 new_value filename
--select new_value filename 
select 'check_'||instance_name||to_char(sysdate,'_YYYYMMDD')||'.log' filename from v$instance;
spool &&filename
--common setting
---公有的设置
set echo on 
set linesize 1000
set pagesize 9999
set trimspool on 
--show instance 
---列出所有和实例相关的状态
col host_name for a20
select * from v$instance;
--show parameter---列出所有参数
col name for a50
col value for a60
select num, name, type, value from v$parameter; 
--show DBID
---列出数据库ID号和数据库名
select dbid,name from v$database;
-- database version
---列出数据库版本号
select *  from v$version;
--datafile total size
---列出数据库永久文件的总的大小（G）
select sum(bytes)/1024/1024/1024 G from dba_data_files;
---列出数据库临时文件的总的大小是（G）
select sum(bytes)/1024/1024/1024 G from dba_temp_files;
-- show sga
---列出数据库SGA信息（Bytes）
show sga;
-- show memory size
---列出数据库内存相关参数的大小（Bytes）

select name, value
  from v$parameter
 where name in ('shared_pool_size',
                'shared_pool_reserved_size',
                'large_pool_size',
                'java_pool_size',
                'db_block_buffers',
                'db_cache_size',
                'sga_max_size',
                'pga_aggregate_target',
                'log_buffer',
                'sort_area_size',
                'sort_area_retained_size',
                'create_bitmap_area_size',
                'bitmap_merge_area_size',
                'hash_area_size');
                
--standard block size---列出数据库内数据块的大小（Bytes）
show parameter db_block_size;
--tablespace number
---列出数据库表空间的数目
select 'tablespace num is '||count(*) from dba_tablespaces;
--datafile number
---列出数据库数据文件的数目
select 'datafile num is '||count(*) from dba_data_files;
--tempfile number
---列出数据库临时文件的数目
select 'tempfile num is '||count(*) from dba_temp_files;
--controlfile number
---列出数据库控制文件的数目
select 'controlfile num is '||count(*) from v$controlfile;
-- ControlFile information---列出控制文件状态，所在位置，是否是恢复区的文件，块的大小（BYTE），包含多少个块
select * from v$controlfile;
-- redo log informationcol member for a40 ---列出重做日志大小（MB），状态，线程,日志组，成员数，序列号等信息
select GROUP#,THREAD#,SEQUENCE#,bytes/1024/1024 MB,MEMBERS,ARCHIVED,STATUS,FIRST_CHANGE#,FIRST_TIME from v$log;
---列出重做日志文件所在位置和状态
select * from v$logfile;
-- log switch information
---列出日志切换的线程号和切换时间
col 00 for '999'
col 01 for '999'
col 02 for '999'
col 03 for '999'
col 04 for '999'
col 05 for '999'
col 06 for '999'
col 07 for '999'
col 08 for '999'
col 09 for '999'
col 10 for '999'
col 11 for '999'
col 12 for '999'
col 13 for '999'
col 14 for '999'
col 15 for '999'
col 16 for '999'
col 17 for '999'
col 18 for '999'
col 19 for '999'
col 20 for '999'
col 21 for '999'
col 22 for '999'
col 23 for '999'
SELECT thread#,
       a.ttime,
       SUM(c8) "08",
       SUM(c9) "09",
       SUM(c10) "10",
       SUM(c11) "11",
       SUM(c12) "12",
       SUM(c13) "13",
       SUM(c14) "14",
       SUM(c15) "15",
       SUM(c16) "16",
       SUM(c17) "17",
       SUM(c18) "18",
       SUM(c0) "00",
       SUM(c1) "01",
       SUM(c2) "02",
       SUM(c3) "03",
       SUM(c4) "04",
       SUM(c5) "05",
       SUM(c6) "06",
       SUM(c7) "07",
       SUM(c19) "19",
       SUM(c20) "20",
       SUM(c21) "21",
       SUM(c22) "22",
       SUM(c23) "23",
       (SUM(c8) + SUM(c9) + SUM(c10) + SUM(c11) + SUM(c12) + SUM(c13) +
       SUM(c14) + SUM(c15) + SUM(c16) + SUM(c17) + SUM(c18) + SUM(c19) +
       SUM(c20) + SUM(c21) + SUM(c22) + SUM(c23) + SUM(c1) + SUM(c2) +
       SUM(c3) + SUM(c4) + SUM(c5) + SUM(c6) + SUM(c7)) "SUNNum"
  FROM (SELECT thread#,
               ttime,
               DECODE(tthour, '00', 1, 0) c0,
               DECODE(tthour, '01', 1, 0) c1,
               DECODE(tthour, '02', 1, 0) c2,
               DECODE(tthour, '03', 1, 0) c3,
               DECODE(tthour, '04', 1, 0) c4,
               DECODE(tthour, '05', 1, 0) c5,
               DECODE(tthour, '06', 1, 0) c6,
               DECODE(tthour, '07', 1, 0) c7,
               DECODE(tthour, '08', 1, 0) c8,
               DECODE(tthour, '09', 1, 0) c9,
               DECODE(tthour, '10', 1, 0) c10,
               DECODE(tthour, '11', 1, 0) c11,
               DECODE(tthour, '12', 1, 0) c12,
               DECODE(tthour, '13', 1, 0) c13,
               DECODE(tthour, '14', 1, 0) c14,
               DECODE(tthour, '15', 1, 0) c15,
               DECODE(tthour, '16', 1, 0) c16,
               DECODE(tthour, '17', 1, 0) c17,
               DECODE(tthour, '18', 1, 0) c18,
               DECODE(tthour, '19', 1, 0) c19,
               DECODE(tthour, '20', 1, 0) c20,
               DECODE(tthour, '21', 1, 0) c21,
               DECODE(tthour, '22', 1, 0) c22,
               DECODE(tthour, '23', 1, 0) c23
          FROM (SELECT thread#,
                       TO_CHAR(first_time, 'yyyy-mm-dd') ttime,
                       TO_CHAR(first_time, 'hh24') tthour
                  FROM v$log_history
                 WHERE (SYSDATE - first_time < 30))) a GROUP BY thread#,ttime;
       
select thread#, to_char(first_time, 'yyyy-mm-dd:hh24:mi:ss')
  from v$log_history
 where first_time > sysdate - 2
 order by first_time desc;

-- archive log list---列出归档相关的信息
archive log list;

--session information
---列出总的会话数量，激活的会话数量，非系统会话数量和系统会话数量
SELECT 'TOTAL SESSIONS NUM IS: ' || COUNT(*)
  FROM v$session UNION ALL SELECT 'ACTIVE SESSIONS NUM IS: ' || COUNT(*)
  FROM v$session
 WHERE status = 'ACTIVE'
UNION ALL SELECT 'USER SESSIONS NUM IS : ' || COUNT(*)
  FROM V$SESSION
 WHERE TYPE = 'USER'
UNION ALL SELECT 'BACKGROUND SESSIONS NUM IS: ' || COUNT(*)
  FROM V$SESSION
 WHERE TYPE = 'BACKGROUND';

--datafile io
---列出数据文件的物理读写情况   
----列出数据文件名，总的物理读写次数，每秒物理读次数，每秒物理写次数，每次读多少数据块，每次写多少数据块，平均I/O时间
col filename for a50
select i.name filename,
       x.phyrds + x.phywrts "total",
       x.phyrds "PHYSRDS",
       x.phywrts "PHYSWRT",
       x.phyblkrd "BLK_RDS",
       x.phyblkwrt "BLK_WRT",
       x.avgiotim "AVGIOTIME"from v$filestat x,
       sys.ts$ ts,
       v$datafile i,
       sys.file$ f where i.file# = f.file# and ts.ts# = f.ts# and x.file# = f.file# order by 2 desc;
--tablespace information
---列出表空间属性，总的大小（MB），总共包含数据块的数量，使用的空间大小（MB），使用率（%），剩余空间的大小（MB）
col tablespace_name for a20
col tablespace_type for a12
col "SUM_SPACE(M)"  for 999999
col SUM_BLOCKS      for 999999999
col "USED_SPACE(M)" for 999999
col "FREE_SPACE(M)" for 999999
col "USED_RATE(%)"  for 999.99
set linesize 200

select t.tablespace_name,
       x.contents            tablespace_type,
       t."SUM_SPACE(M)",
       t.SUM_BLOCKS,
       t."USED_SPACE(M)",
       t."USED_RATE(%)",
       t."FREE_SPACE(M)" from (SELECT D.TABLESPACE_NAME,
                                     SPACE "SUM_SPACE(M)",
                                     BLOCKS SUM_BLOCKS,
                                     SPACE - NVL(FREE_SPACE, 0) "USED_SPACE(M)",
                                     ROUND((1 - NVL(FREE_SPACE, 0) / SPACE) * 100,
                                           2) "USED_RATE(%)",
                                     FREE_SPACE "FREE_SPACE(M)"
                                FROM (SELECT TABLESPACE_NAME,
                                             ROUND(SUM(BYTES) / (1024 * 1024),
                                                   2) SPACE,
                                             SUM(BLOCKS) BLOCKS
                                        FROM DBA_DATA_FILES
                                       GROUP BY TABLESPACE_NAME) D,
                                     (SELECT TABLESPACE_NAME,
                                             ROUND(SUM(BYTES) / (1024 * 1024),
                                                   2) FREE_SPACE
                                        FROM DBA_FREE_SPACE
                                       GROUP BY TABLESPACE_NAME) F
                               WHERE D.TABLESPACE_NAME =
                                     F.TABLESPACE_NAME(+)
                              UNION ALL
                              SELECT D.TABLESPACE_NAME,
                                     SPACE "SUM_SPACE(M)",
                                     BLOCKS SUM_BLOCKS,
                                     USED_SPACE "USED_SPACE(M)",
                                     ROUND(NVL(USED_SPACE, 0) / SPACE * 100,
                                           2) "USED_RATE(%)",
                                     SPACE - USED_SPACE "FREE_SPACE(M)"
                                FROM (SELECT TABLESPACE_NAME,
                                             ROUND(SUM(BYTES) / (1024 * 1024),
                                                   2) SPACE,
                                             SUM(BLOCKS) BLOCKS
                                        FROM DBA_TEMP_FILES
                                       GROUP BY TABLESPACE_NAME) D,
                                     (SELECT TABLESPACE,
                                             ROUND(SUM(BLOCKS * 8192) /
                                                   (1024 * 1024),
                                                   2) USED_SPACE
                                        FROM V$tempseg_USAGE
                                       GROUP BY TABLESPACE) F
                               WHERE D.TABLESPACE_NAME = F.TABLESPACE(+)) t,
       dba_tablespaces       x where t.tablespace_name = x.tablespace_name order by "USED_RATE(%)" desc;


---列出表空间总的大小（MB），使用的空间大小（MB），剩余空间的大小（MB），空闲率（%），最大的扩展的大小（K），扩展的数量。

select tablespace_name,
       sum_alloc_bytes / 1024 / 1024 Total_MB,
       (sum_alloc_bytes - sum_free_bytes) / 1024 / 1024 Used_MB,
       sum_free_bytes / 1024 / 1024 Free_MB,
       to_char(100 * sum_free_bytes / sum_alloc_bytes, '99.9999') || '%' as pct_free,
       max_chunk / 1024 "MAXCHUNK(K)",
       count_chunk from (select tablespace_name,
                               sum(bytes) as sum_alloc_bytes from dba_data_files group by tablespace_name) a1,
       (select tablespace_name as fs_ts_name,
               max(bytes) as max_chunk,
               count(bytes) as count_chunk,
               sum(bytes) as sum_free_bytes from dba_free_space group by tablespace_name) b1 where a1.tablespace_name = b1.fs_ts_name;


---列出表空间块的大小（BYTE），是否在线，属性，是否记录日志，是否是本地管理，段管理方式和分配类型。
select tablespace_name,
       block_size,
       status,
       contents,
       logging,
       extent_management        ext_mag,
       SEGMENT_SPACE_MANAGEMENT seg_mag,
       ALLOCATION_TYPE          alloc_type
  from DBA_TABLESPACES;
  
-- datafile information
---数据文件总的大小（MB），剩余大小（MB），空闲率（%）
select a.name, a.total, b.free, b.free / a.total * 100 pct_free
  from (select name, rfile#, sum(bytes) / 1024 / 1024 total
          from v$datafile
         group by name, rfile#) a,
       (select file_id, sum(bytes) / 1024 / 1024 free
          from dba_free_space
         group by file_id) b where b.FILE_ID = a.rfile#;


---数据文件所在的表空间名，数据文件的位置，是否可用，数据文件的大小（BYTE），是否是自动扩展
col file_name for a40
col bytes for 99999999999
select tablespace_name, file_name, status, bytes, autoextensible auto from dba_data_files;

-- tempfile information
---临时文件的文件号，所在位置，大小（MB），是否在线，是否是读写状态。
col name format a50 truncate;
select ts#,file#,name,trunc(bytes/1024/1024) sizeMB,status,enabled from v$tempfile;
---临时表空间的名字，初始的大小（K），下次的大小（K）

select tablespace_name, initial_extent, next_extent from dba_tablespaces where contents like 'TEMPORARY' ;

--Rollback information
---列出回滚段的名字，回滚段包含的扩展的数量，初始大小（BYTE），最佳大小（BYTE），收缩的的次数，平均收缩的次数，平均激活的次数，
---翻滚的次数，扩展的次数
col name for a10
col ext for a5
select a.name,
       to_char(b.extents) ext,
       b.rssize,
       b.optsize,
       b.shrinks,
       b.aveshrink,
       b.aveactive,
       b.wraps,
       b.extends
  from v$rollname a, v$rollstat b
 where a.usn = b.usn;
--Show user name
---列出数据库所有用户的名字，是否锁定，概要，默认表空间
select username, account_status, profile, default_tablespace, temporary_tablespace from dba_users;
--Show Sort
---列出数据库在内存和硬盘中排序的次数，以及排序了多少行
col name for a15
col value for '9999999999999999'
select name, value from v$sysstat where name like '%sort%';
--Please adjust the max_extents of these segments
---列出即将要达到最大扩展数量的段的名字，扩展数量和最大扩展数量
SELECT segment_name,EXTENTS,max_extents FROM DBA_SEGMENTS WHERE (max_extents - EXTENTS) < 5;

--Top 20 physical reads segments
---列出使用物理读的前20的段的所有者，对象名，对象种类，物理读的次数，对象大小（MB）

select b.*, sum(a.bytes) / 1024 / 1024 "SIZE"
  from dba_segments a,
       (SELECT *
          FROM (SELECT owner, object_name, object_type, value
                  FROM v$segment_statistics
                 WHERE statistic_name = 'physical reads'
                 ORDER BY VALUE DESC) a1 WHERE ROWNUM < 21) b where a.SEGMENT_NAME = b.object_name and a.OWNER = b.owner group by b.owner,
       b.object_name,
       object_type,
       value order by value desc;

--Top 30 logical reads segments
---列出使用逻辑读的前30的段的所有者，对象名，对象种类，逻辑读的次数，对象大小（MB）
select b.*, sum(a.bytes) / 1024 / 1024 "SIZE"
  from dba_segments a,
       (SELECT *
          FROM (SELECT owner, object_name, object_type, value
                  FROM v$segment_statistics
                 WHERE statistic_name = 'logical reads'
                 ORDER BY VALUE DESC) a1
         WHERE ROWNUM < 31) b
 where a.SEGMENT_NAME = b.object_name
   and a.OWNER = b.owner
 group by b.owner, b.object_name, object_type, value
 order by value desc;

---列出所有等待事件的名称，总的等待次数，总的时间耗尽次数，总的等待时间，平均等待时间，总的等待时间（微秒），
---事件的ID号，等待种类ID，等待种类号，等待种类，启动数据库时间

select a.*, b.startup_time from v$system_event a,v$instance b WHERE a.event NOT IN ('SQL*Net message from client','jobq slave wait','PL/SQL lock timer','PX Idle Wait','SQL*Net message from dblink','dispatcher timer','pipe get','pmon timer','queue messages','rdbms ipc message','single-task message','smon timer','virtual circuit status','wait for activate message','wait for transaction','wakeup event for builder','wakeup event for preparer','wakeup event for reader','wakeup time manager','Null event','ges remote message','gcs remote message') AND a.EVENT NOT LIKE 'PX Deq%'order by a.time_waited desc;

--PGA information
---列出PGA相关信息的名称，值和单位
col name for a50
SELECT * FROM v$pgastat;
--TABLE chain information
---列出所有有表链接的表名，空闲百分比，包含的行数，数据块的数量，表链接的行数
Select table_name,pct_free,num_rows,blocks,chain_cnt,chain_cnt/num_rows pct_chain From dba_tables where chain_cnt>0;
 --check hot sql
 ---列出所有内存中执行次数大于100并且加载次数大于1的触发器，程序，包体，包的所有者对象名称，对象种类，
 ---可分享的内存大小（BYTE），执行次数，加载次数，对象是否永久固定在内存中
 
 col owner format a15 truncate;
 col objectname format a35 truncate;
 col type format a12 truncate;
SELECT substr(owner,1,15) owner,substr(name,1,35) ObjectName,       substr(type,1,12) type,sharable_mem,executions,loads,kept  FROM v$db_object_cache  WHERE type in ('TRIGGER','PROCEDURE','PACKAGE BODY','PACKAGE')   AND  executions > 100 AND LOADS>1  ORDER BY executions desc,           loads desc,           sharable_mem desc;               
 --BUFFER HIT RATIO (should be > 70, else increase db_block_buffers in init.ora)
 ---列出BUFFER中逻辑读次数，物理读次数，物理写次数，BUFFER的命中率
 ---BUFFER的命中率（因该大于70，否则应该调整db_block_buffers的大小）
 
 column "logical_reads" format 99,999,999,999  
 column "phys_reads" format 999,999,999  
 column "phy_writes" format 999,999,999 
select a.value + b.value "logical_reads",                  c.value   "phys_reads",                  d.value   "phy_writes",                  round(100 * ((a.value+b.value)-c.value) /                (a.value+b.value))                  "BUFFER HIT RATIO"  from v$sysstat a, v$sysstat b, v$sysstat c, v$sysstat d  where          a.name = 'db block gets'  and          b.name = 'consistent gets'  and          c.name = 'physical reads' and          d.name = 'physical writes'; 
          
 --DATA DICT HIT RATIO (should be higher than 90 else increase shared_pool_size in init.ora)  
 ---列出数据字典命中次数，MISS次数，命中率（应该高于90%，否则增加shared_pool_size参数的大小）
 column "Data Dict. Gets"   format 999,999,999  
 column "Data Dict.cache misses" format 999,999,999  
 select sum(gets) "Data Dict. Gets",        sum(getmisses) "Data Dict. cache misses",        trunc((1-(sum(getmisses)/sum(gets)))*100)        "DATA DICT CACHE HIT RATIO"  from v$rowcache; 
   
 --Library Cache Section (hit ratio should be > 70, and pin ratio > 70 .)
 ---列出库缓存中的命名空间，命中率，PIN的命中率，重新装载的次数（命中率和PIN的命中率应该大于70）
 
 column "reloads" format 999,999,999  
select namespace, trunc(gethitratio * 100) "Hit ratio",  trunc(pinhitratio * 100) "pin hit ratio", reloads "reloads"  from v$librarycache; 
--Pool's Free Memory
---列出共享池，大池，JAVA池的剩余空间大小（BYTE）
set heading on
column bytes format 999,999,999,999  
select pool,name, bytes from v$sgastat where name = 'free memory';                  
--ORA-4031检查

column indx heading "indx|indx num"
column kghlurcr heading "RECURRENT|CHUNKS"
column kghlutrn heading "TRANSIENT|CHUNKS"
column kghlufsh heading "FLUSHED|CHUNKS"
column kghluops heading "PINS AND|RELEASES"
column kghlunfu heading "ORA-4031|ERRORS"
column kghlunfs heading "LAST ERROR|SIZE"
select  indx,  kghlurcr,  kghlutrn,  kghlufsh,  kghluops,  kghlunfu,  kghlunfs from  sys.x$kghlu where  inst_id = userenv('Instance');
---列出数据库系统事件统计名和发生的次数

col system_statistic format a55 truncate;
column value format 999,999,999,999  
select substr(name,1,55) system_statistic, value   from v$sysstat   order by name;
    
---列出隐含数据参数为_kghdsidx_count的值（这个参数为共享池中子池的数量）
col param format a40 truncate;
col vals format a30 truncate;
select a.ksppinm param, b.ksppstvl vals from   x$ksppi a, x$ksppsv b where  a.indx = b.indx and    a.ksppinm = '_kghdsidx_count';
--检查行迁移比例
col RT for a5
--取行迁移TOP20的表

select * from (select table_name,num_rows,CHAIN_CNT,ROUND((CHAIN_CNT/num_rows)*100,2) as "RT%" from dba_tables where num_rows>0 and CHAIN_CNT>0order by CHAIN_CNT/num_rows desc)where rownum<=20;

--取行迁移超过3%的表

select table_name,num_rows,CHAIN_CNT,ROUND((CHAIN_CNT/num_rows)*100,2) as "RT%" from (select * from dba_tables where num_rows>0 and CHAIN_CNT>0)where (CHAIN_CNT/num_rows)*100>3order by CHAIN_CNT/num_rows desc;

--平均事务响应时间--必须要一直搜集statspack数据
column snap_id format a20
column b_time format a22
column e_time format a22
column elapse_time format a10
column resp_tran format a8
column resp_call format a8

select a.snap_id || '--' || b.snap_id snap_id, --开始到结束快照ID       
       to_char(a.snap_time, 'yyyy-mm-dd hh24:mi:ss') b_time, --快照开始时间       
       to_char(b.snap_time, 'yyyy-mm-dd hh24:mi:ss') e_time, --快照结束时间       
       to_char((b.snap_time - a.snap_time) * 1440, '999,90.00') elapse_time, --快照时间长度       
       to_char((b.total_time_waited_micro - a.total_time_waited_micro +
               b.cpu_time - a.cpu_time) / (b.total_trans - a.total_trans),
               '90.00') resp_tran, --每事务响应时间       
       to_char((b.total_time_waited_micro - a.total_time_waited_micro +
               b.cpu_time - a.cpu_time) / (b.total_calls - a.total_calls),
               '90.00') resp_call --没call响应时间  
  from (select rownum R_NO,
               e.snap_id,
               s.snap_time,
               e.total_time_waited_micro,
               sy.cpu_time,
               calls.total_calls,
               trans.total_trans
          from (select snap_id,
                       sum(time_waited_micro) / 1000000 total_time_waited_micro
                  from stats$system_event
                 where event not in (select event from stats$idle_event)
                 group by snap_id
                 order by snap_id) e,
               stats$snapshot s,
               (select snap_id, value / 100 cpu_time
                  from stats$sysstat
                 where STATISTIC# = 12) sy,
               (select snap_id, value Total_calls
                  from stats$sysstat
                 where STATISTIC# = 6) calls,
               (select snap_id, sum(value) Total_trans
                  from stats$sysstat
                 where STATISTIC# = 4
                    or STATISTIC# = 5
                 group by snap_id) trans
         where e.snap_id = s.snap_id
           and e.snap_id = sy.snap_id
           and e.snap_id = calls.snap_id
           and e.snap_id = trans.snap_id
         order by e.snap_id) a,
       (select rownum R_NO,
               e.snap_id,
               s.snap_time,
               e.total_time_waited_micro,
               sy.cpu_time,
               calls.total_calls,
               trans.total_trans
          from (select snap_id,
                       sum(time_waited_micro) / 1000000 total_time_waited_micro
                  from stats$system_event
                 where event not in (select event from stats$idle_event)
                 group by snap_id
                 order by snap_id) e,
               stats$snapshot s,
               (select snap_id, value / 100 cpu_time
                  from stats$sysstat
                 where STATISTIC# = 12) sy,
               (select snap_id, value Total_calls
                  from stats$sysstat
                 where STATISTIC# = 6) calls,
               (select snap_id, sum(value) Total_trans
                  from stats$sysstat
                 where STATISTIC# = 4
                    or STATISTIC# = 5
                 group by snap_id) trans
         where e.snap_id = s.snap_id
           and e.snap_id = sy.snap_id
           and e.snap_id = calls.snap_id
           and e.snap_id = trans.snap_id
         order by e.snap_id) b
 where b.r_no = a.r_no + 1;

--###############################################################
--#数据库内表的大小在前30的表相关信息检查脚本                 
--#--# 数据库内记录行数在前30的表相关信息检查脚本                 
--#--#  按表的行数来排列，如果表分析不频繁，所取信息可能不够准确； 
--#--#  分析表命令：analyze table table_name compute statistics;   
--###############################################################
set line 9999;
column owner format a10;
column TABLE_NAME format a30;
column tablespace_name format a20;
column TYPE format a20;
column partition_name format a30;

--数据库内表的大小在前30的表相关信息(包括分区表分区信息)

select b.owner,
       b.TABLE_NAME,
       b.TYPE,
       b."TABLE_SIZE(MB)",
       a.tablespace_name,
       a.partition_name,
       decode(TRIM(b.TYPE),
              'TABLE PARTITION',
              round(a.bytes / 1024 / 1024, 2),
              NULL) as "PARTITION_SIZE(MB)"
  from dba_segments a,
       (select *
          from (select owner,
                       segment_name TABLE_NAME,
                       segment_type TYPE,
                       round(sum(bytes / 1024 / 1024), 2) as "TABLE_SIZE(MB)"
                  from dba_segments
                 where segment_type in ('TABLE', 'TABLE PARTITION')
                 group by owner, segment_name, segment_type
                 order by "TABLE_SIZE(MB)" desc)
         where rownum <= 30) b
 where a.segment_name = b.TABLE_NAME
   and a.owner = b.owner
 order by b."TABLE_SIZE(MB)"   desc,
          "PARTITION_SIZE(MB)" desc,
          a.partition_name;


--数据库内记录行数在前30的表相关信息(基于表分析的结果进行查询)

column table_name format a30;
column segment_type format a20;
select t.owner,
       t.table_name,
       t.tablespace_name,
       s.segment_type,
       t.num_rows,
       s.MB "TABLE_SIZE(MB)",
       t.last_analyzed
  from (select *
          from (select owner,
                       table_name,
                       tablespace_name,
                       num_rows,
                       last_analyzed
                  from dba_tables
                 where num_rows > 0
                 order by num_rows desc)
         where rownum <= 30) t,
       (select owner,
               segment_name,
               round(sum(bytes / 1024 / 1024), 2) MB,
               segment_type
          from dba_segments
         group by owner, segment_name, segment_type) s
 where t.table_name = s.segment_name
 order by t.num_rows desc, MB desc;

---临时表空间大小

SELECT D.TABLESPACE_NAME,
       SPACE "SUM_SPACE(M)",
       BLOCKS SUM_BLOCKS,
       USED_SPACE "USED_SPACE(M)",
       ROUND(NVL(USED_SPACE, 0) / SPACE * 100, 2) "USED_RATE(%)",
       NVL(FREE_SPACE, 0) "FREE_SPACE(M)" FROM (SELECT TABLESPACE_NAME,
                                                      ROUND(SUM(BYTES) /
                                                            (1024 * 1024),
                                                            2) SPACE,
                                                      SUM(BLOCKS) BLOCKS FROM DBA_TEMP_FILES GROUP BY TABLESPACE_NAME) D,
       (SELECT TABLESPACE_NAME,
               ROUND(SUM(BYTES_USED) / (1024 * 1024), 2) USED_SPACE,
               ROUND(SUM(BYTES_FREE) / (1024 * 1024), 2) FREE_SPACE FROM V$TEMP_SPACE_HEADER GROUP BY TABLESPACE_NAME) F WHERE D.TABLESPACE_NAME = F.TABLESPACE_NAME(+);


--datafile autoextend times and size

--数据文件自动扩展次数和大小
column tablespace_name format a20;
column file_name format a45;
select tablespace_name,
       file_id file#,
       file_name,
       trunc(maxblocks / increment_by) max_times,
       trunc((maxblocks - blocks) / increment_by) remain_times,
       (maxbytes - bytes) / 1024 / 1024 remain_MB
  from dba_data_files
 where autoextensible like 'YES'
 order by remain_times, remain_MB;

---列出估算所需UNDO表空间的大小（MB）

SELECT ((UR * (UPS * DBS)) + (DBS * 24)) / 1024 / 1024 AS "Undo_tablespace_MB" FROM (SELECT value AS UR FROM v$parameter WHERE name = 'undo_retention'),
       (SELECT (SUM(undoblks) / SUM(((end_time - begin_time) * 86400))) AS UPS FROM v$undostat where undoblks > 1000),
       (SELECT value AS DBS FROM v$parameter WHERE name = 'db_block_size');


--Log Buffer information
---列出log buffer space等待事件的会话ID，事件名，最后的seconds_in_wait和state列相关
---如果state值为Waiting，那么wait_time值无用。Second_in_wait值是实际的等待时间(单位：秒)。
---如果state值为Wait unknow time，那么wait_time值和Second_in_wait值都无用。
---如果state值为Wait short time，那么wait_time值和Second_in_wait值都无用。
---如果state值为Waiting known time，那么wait_time值就是实际等待时间(单位：秒)，Second_in_wait值无用。

SELECT sid, event, seconds_in_wait, state FROM   v$session_wait WHERE  event = 'log buffer space%';

---列出在日志缓冲区总再次尝试分配可用空间的次数，登入的次数，以及两者之间的比率

SELECT r.value "Retries",
       e.value "Entries",
       r.value / e.value * 100 "Percentage"
  FROM v$sysstat r, v$sysstat e
 WHERE r.name = 'redo buffer allocation retries'
   AND e.name = 'redo entries';


--Shared Pool information
---列出SQL AREA的命中率

select namespace,gethitratio from v$librarycache where namespace = 'SQL AREA';

---列出在LIBRARYCACHE中执行的次数，MISS的次数和MISS所占的比率

SELECT SUM(pins) "Executions", SUM(reloads) "Cache Misses",          SUM(reloads)/SUM(pins) FROM v$librarycache;
---列出缓存的命中率
SELECT 1 - (phy.value - lob.value - dir.value) / ses.value "CACHE HIT RATIO" FROM v$sysstat ses,
       v$sysstat lob,
       v$sysstat dir,
       v$sysstat phy WHERE ses.name = 'session logical reads' AND dir.name = 'physical reads direct' AND lob.name = 'physical reads direct (lob)' AND phy.name = 'physical reads';

--检查CURSORS信息

col parameter format a20 truncate;
col usage format a10 truncate;
col value format a10 truncate;

select 'session_cached_cursors' parameter,
       lpad(value, 5) value,
       decode(value, 0, '  n/a', to_char(100 * used / value, '990') || '%') usage from (select max(s.value) used
                                                                                         from v$statname n,
                                                                                              v$sesstat  s
                                                                                        where n.name =
                                                                                              'session cursor cache count'
                                                                                          and s.statistic# =
                                                                                              n.statistic#),
       (select value from v$parameter where name = 'session_cached_cursors') union all select 'open_cursors' parameter,
       lpad(value, 5) value,
       to_char(100 * used / value, '990') || '%' usage from (select max(sum(s.value)) used
                                                              from v$statname n,
                                                                   v$sesstat  s
                                                             where n.name in
                                                                   ('opened cursors current',
                                                                    'session cursor cache count')
                                                               and s.statistic# =
                                                                   n.statistic#
                                                             group by s.sid),
       (select value from v$parameter where name = 'open_cursors');
       
       
       
col cursor_cache_hits format a20 truncate;
col soft_parses format a20 truncate;
col hard_parses format a20 truncate;
select to_char(100 * sess / calls, '9999990.00') || '%' cursor_cache_hits,
       to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' soft_parses,
       to_char(100 * hard / calls, '999990.00') || '%' hard_parses from (select value calls
                                                                          from v$sysstat
                                                                         where name =
                                                                               'parse count (total)'),
       (select value hard from v$sysstat where name = 'parse count (hard)'),
       (select value sess
          from v$sysstat
         where name = 'session cursor cache hits');   


--RAC信息

col value clear
SELECT INST_ID,NAME,VALUE FROM GV$SYSSTAT WHERE NAME LIKE '%global%';
select cr_requests cr,current_requests cur,data_requests data,undo_requests undo,tx_requests tx from   v$cr_block_server;
select cr_requests,light_works from v$cr_block_server;
select data_requests,fairness_down_converts from v$cr_block_server;
select inst_id,status,count(*) from gv$bh group by inst_id,status;

SPOOL OFF