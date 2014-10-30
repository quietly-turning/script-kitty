Lesson.create( title: 'What is SQL?', objective: 'Write a simple query.',
body: '<p>
	<strong>Why do databases matter?</strong><br>
	It is likely that you interact with databases on a daily basis but don\'t realize it.
	Popular websites like Google, Facebook, and YouTube all rely on databases. 	Databases contain data in a way that makes them easily searched, filtered, and retrieved.  That searching, filtering, and retrieval is done using a language called SQL or <strong>S</strong>tructured <strong>Q</strong>uery <strong>L</strong>anguage.
</p>
	
<p>
	Before we jump into learning SQL, there is some foundational terminology that is important to grasp first.
</p>
	
<p>
	Here is a very simple database consisting of a single table that contains eight columns and six rows (don\'t include the header row in your count):
<p>

<table>
		  <thead>
		    <tr>
				  <th>ID</th>
			      <th>Name</th>
			      <th>City</th>
			      <th>State</th>
			      <th>Zip</th>
			      <th>Chief</th>
			      <th>Control ID</th>
			      <th>Locale ID</th>
		    </tr>
		  </thead>

		  <tbody>
		      <tr>
				<td>1</td>
		        <td>Community College of the Air Force</td>
		        <td>Montgomery</td>
		        <td>AL</td>
		        <td>36114-0011</td>
		        <td>Timothy W. Albrecht</td>
		        <td>1</td>
		        <td>2</td>
		      </tr>
		      <tr>
				<td>2</td>
		        <td>Alabama A &amp; M University</td>
		        <td>Normal</td>
		        <td>AL</td>
		        <td>35762</td>
		        <td>Dr. Andrew Hugine, Jr.</td>
		        <td>1</td>
		        <td>2</td>
		      </tr>
		      <tr>
				<td>3</td>
		        <td>University of Alabama at Birmingham</td>
		        <td>Birmingham</td>
		        <td>AL</td>
		        <td>35294-0110</td>
		        <td>Carol Z. Garrison</td>
		        <td>1</td>
		        <td>2</td>
		      </tr>
		      <tr>
				<td>4</td>
		        <td>Amridge University</td>
		        <td>Montgomery</td>
		        <td>AL</td>
		        <td>36117-3553</td>
		        <td>Michael Turner</td>
		        <td>2</td>
		        <td>2</td>
		      </tr>
		      <tr>
				<td>5</td>
		        <td>University of Alabama at Huntsville</td>
		        <td>Huntsville</td>
		        <td>AL</td>
		        <td>35899</td>
		        <td>David B. Williams</td>
		        <td>1</td>
		        <td>2</td>
		      </tr>
		      <tr>
				<td>6</td>
		        <td>Alabama State University</td>
		        <td>Montgomery</td>
		        <td>AL</td>
		        <td>36101-0271</td>
		        <td>William H. Harris</td>
		        <td>1</td>
		        <td>2</td>
		      </tr>
	</tbody>
</table>

<p>
	In this example,
</p>' )

Lesson.create( title: 'Introduction To Conditional Statements', objective: 'Filter your results with a single condition.', body: '' )

Lesson.create( title: 'Equals is not the only operator', objective: 'Search through text using the <em>like</em> operator.', body: '' )

Lesson.create( title: 'Compound Conditional Statements: Part 1', objective: 'Chain two conditions together with <em>or</em>.', body: '' )

Lesson.create( title: 'Compound Conditional Statements: Part 2', objective: 'Chain two conditions together  <em>and</em>.', body: '' )

Lesson.create( title: 'Does Not Equal', objective: 'Filter your results using the <em>does not equal</em> operator.', body: '' )

Lesson.create( title: 'Being more specific than SELECT *', objective: 'Limit results to specific columns from the databse table.', body: '' )

Lesson.create( title: 'Using More Than One Table', objective: 'Write a complex query that pulls data from more than one table.', body: '' )