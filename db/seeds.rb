# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


template = Template.create([{id:'1',html:'<html>
<head>
</head>
<body>

 <table  border="1" >
	    <tr>
	    	<td>
	    		<h2><em>Wishes On Your Brthday</em></h2>
	    		<br/>
	    		<br/>
	
	    		<p><span>Life is just an act. The ingredients of success</span></p> 
	    		<p>	needed are a killing cast, a remarkable plot</p> 
	    		<p>	and an unflinching director. I think you have</p>
	    	    <p>   all it needs</p>
	            <br/>
	            <br/>
	    	    <p>Regards</p>

	    	</td>
	   
	    	<td>
	     	<img src="https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQg8bfIehM38R8WAgubLUFzHqTcFSC9AnpA95tm6J3DAnI9qogK" width="160" height="160" border="5"></img>
	       </td>
	    </tr>

</table>
	
</body>
</html>

'}])

department = Department.create([{id:'1' ,dept:'ALL'}]) 
team = Team.create([{id:'1' ,team_name:'ALL'}]) 