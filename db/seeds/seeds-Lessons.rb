Lesson.create( title: 'What is SQL?', objective: 'Write a simple query.',
body: "
<p>
	<strong>Why do databases matter?</strong><br>
	It is likely that you interact with databases on a daily basis but don't realize it.
	Popular websites like Google, Facebook, and YouTube all rely on databases. 	Databases contain data in a way that makes them easily searched, filtered, and retrieved.  That searching, filtering, and retrieval is done using a language called SQL or <strong>S</strong>tructured <strong>Q</strong>uery <strong>L</strong>anguage.
</p>
	
<p>
	Before we jump into learning SQL, there is some foundational terminology that is important to learn first.
</p>



<h3>Terminology</h3>

<p>
	Here is a very simple database consisting of a single table that contains eight columns and six rows (don't include the header row in your count).
<p>


<h4>Schools</h4>
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
	This simple example contains information about schools and demonstrates many
	key attribtues of database structure.  Each horizontal <strong>row</strong> represents
	one school.  For example:
	
	<table>
		<tbody>
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
	
	is a single row containing data about Alabama State University.
</p>
<p>	
	Each cell gives us information about a particular attribute of that school.
	For example, the <em>Name</em> of a school is an attribute of it, and contained
	in the second column in this example.  Indeed, these attributes are commonly
	referred to as <strong>columns</strong> or <strong>fields</strong> in database
	terminology.
</p>

<p>
	The rows and columns as a cohesive unit are known as a <strong>table</strong>.
	In this example, the table is <em>Schools</em>.
</p>

<p>
	Finally, a collection of multiple tables is referred to as a <strong>database</strong>.  
	Through out the upcoming exercises, we'll be working with three different tables: <em>schools</em>,
	<em>locales</em>, and <em>controls</em>.  Feel free to explore these tables by clicking on
	<em>Datasets</em> at the top of the page.
</p>

<hr>

<h3>Introduction to SQL</h3>

<p>
	SQL (<strong>S</strong>tructured <strong>Q</strong>uery <strong>L</strong>anguage) is a language used
	to interact with databases.  These interactions are often summarized (humerously) with the
	acronym CRUD, which stands for:     
	<ul>                                
		<li><strong>C</strong>reate</li>
		<li><strong>R</strong>etrieve</li>  
		<li><strong>U</strong>pdate</li>
		<li><strong>D</strong>elete</li>
	</ul>
	
	Those four actions neatly encapsulate essentially everything databases can do.  In these lessons, we will be focusing on <em>Retrieving</em> data using SQL queries.
</p>

<p>
	Databases typically contain lots (and lots) of data that would be cumbersome to sift through manually.
	An SQL <strong>query</strong> is like a question we ask the database.  <em>Can you show me some specific
	data based on these specific parameters I'll provide?</em>  Without further ado, let's look at a very simple
	SQL query.
</p>

<textarea class='raw-sql' style='height:1em'>SELECT *
FROM schools</textarea>

<p>
	What does this do?  Let's break it down word by word.
</p>

<p>
	A typical query will contain a combination of <em>keywords</em> and words that are specific to your situation.
	In this example, and throughout the following lessons, keywords will be capitalized. SELECT and FROM are both keywords.
	They will appear in every query you ever write. The asterisk character and <em>schools</em> are
	both specific to this example.
</p>

<ul>
	<li>SELECT is like saying <em>please find for me...</em></li>
	<li>The asterisk is a <em>wildcard</em> character that means <em>everything available</em>.</li>
</ul>

<p>	
	So, the statement <strong>SELECT *</strong> is like saying <em>please find for me everything available</em>
</p>

<ul>
	<li>The keyword FROM tells the database in what table(s) to look</li>
	<li><em>schools</em> is the name of the table we want it to look in</li>
</ul>

<p>
	So, in plain English, this query might read <em>please find everything available from the schools table</em>.
</p>

<hr>

<p>
	Let's try it out!
</p>

" )

Lesson.create( title: 'Introduction To Conditional Statements', objective: 'Filter your results with a single condition.', body: '' )

Lesson.create( title: 'Equals is not the only operator', objective: 'Search through text using the <em>like</em> operator.', body: '' )

Lesson.create( title: 'Compound Conditional Statements: Part 1', objective: 'Chain two conditions together with <em>or</em>.', body: '' )

Lesson.create( title: 'Compound Conditional Statements: Part 2', objective: 'Chain two conditions together  <em>and</em>.', body: '' )

Lesson.create( title: 'Does Not Equal', objective: 'Filter your results using the <em>does not equal</em> operator.', body: '' )

Lesson.create( title: 'Being more specific than SELECT *', objective: 'Limit results to specific columns from the databse table.', body: '' )

Lesson.create( title: 'Using More Than One Table', objective: 'Write a complex query that pulls data from more than one table.', body: '' )