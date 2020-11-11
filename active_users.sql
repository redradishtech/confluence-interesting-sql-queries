-- Users counting towards your Confluence license count.
create schema if not exists queries;
drop view if exists queries.active_users;
create view queries.active_users AS
	select distinct
		cwd_user.user_name
		,cwd_user.email_address
		,cwd_user.created_date
	from cwd_directory JOIN cwd_user ON cwd_user.directory_id=cwd_directory.id
		JOIN cwd_membership ON cwd_user.id = cwd_membership.child_user_id
		JOIN cwd_group ON cwd_membership.parent_id=cwd_group.id
		JOIN spacepermissions ON spacepermissions.permgroupname=cwd_group.group_name
	where cwd_user.active='T' and cwd_directory.active='T' and permtype='USECONFLUENCE'
	order by user_name;
