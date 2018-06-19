Lesson.create( title: 'What is SQL?', objective: 'Write a simple query.', body: "

<h3>Why do databases matter?</h3>
<p>
	It is likely that you interact with databases on a daily basis but don't realize it.
	Popular websites like Google, Facebook, and YouTube all rely on databases.
	Databases contain data in a way that makes them easily searched, filtered, and retrieved.
</p>
<p>
	That searching, filtering, and retrieval is most often done using a language called SQL or
	<strong>S</strong>tructured <strong>Q</strong>uery <strong>L</strong>anguage.
</p>

<p>
	Before we jump into learning SQL, there is some foundational terminology that is important to learn first.
</p>



<h3>Terminology</h3>

<p>
	Here is a very simple database consisting of a single table that contains seven columns and six rows (don't include the header row in your count).
<p>

<h2>Schools</h2>
<table class='table table-bordered table-responsive'>
	<caption>Schools</caption>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
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
			<td>2</td>
		</tr>
		<tr>
			<td>2</td>
			<td>Alabama A &amp; M University</td>
			<td>Normal</td>
			<td>AL</td>
			<td>35762</td>
			<td>Dr. Andrew Hugine, Jr.</td>
			<td>2</td>
		</tr>
		<tr>
			<td>3</td>
			<td>University of Alabama at Birmingham</td>
			<td>Birmingham</td>
			<td>AL</td>
			<td>35294-0110</td>
			<td>Carol Z. Garrison</td>
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
		</tr>
		<tr>
			<td>5</td>
			<td>University of Alabama at Huntsville</td>
			<td>Huntsville</td>
			<td>AL</td>
			<td>35899</td>
			<td>David B. Williams</td>
			<td>2</td>
		</tr>
		<tr>
			<td>6</td>
			<td>Alabama State University</td>
			<td>Montgomery</td>
			<td>AL</td>
			<td>36101-0271</td>
			<td>William H. Harris</td>
			<td>2</td>
		</tr>
	</tbody>
</table>

<p>
	This simple example contains information about schools and demonstrates many
	key attribtues of database structure.  Each horizontal <strong>row</strong> represents
	one school.  For example:

	<table class='table table-bordered table-responsive'>
		<tbody>
			<tr>
				<td>6</td>
				<td>Alabama State University</td>
				<td>Montgomery</td>
				<td>AL</td>
				<td>36101-0271</td>
				<td>William H. Harris</td>
				<td>1</td>
			</tr>
		</tbody>
	</table>

	is a single row containing data about Alabama State University.
</p>
<p>
	Each cell gives us information about a particular attribute of that school.
	For example, the <em>name</em> of a school is an attribute of it, and contained
	in the second column in this example.  These attributes are commonly
	referred to as <strong>columns</strong> or <strong>fields</strong> in database
	terminology.
</p>

<p>
	The rows and columns as a cohesive unit are known as a <strong>table</strong>.
	In this example, the table is <em>Schools</em>.
</p>

<p>
	Finally, a collection of multiple tables is referred to as a <strong>database</strong>.
	Through out the upcoming exercises, we'll be working with a database of three different tables:
	<em>schools</em>, <em>locales</em>, and <em>websites</em>.  Feel free to explore these tables
	by clicking on <em>Tables</em> at the top of the page.
</p>

<hr>

<h3>Introduction to SQL</h3>

<p>
	SQL (<strong>S</strong>tructured <strong>Q</strong>uery <strong>L</strong>anguage) is a language used
	to interact with databases.  These interactions are often summarized (humorously) with the
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
	A SQL <strong>query</strong> is like a question we ask the database.  <em>Can you show me some specific
	data based on these specific filters I'll provide?</em>  Without further ado, let's look at a very simple
	SQL query.
</p>

<textarea class='raw-sql'>SELECT *
FROM schools</textarea>

<p>
	What does this do?  Let's break it down word by word.
</p>

<p>
	A typical query will contain a combination of <em>keywords</em> and words that are specific to your situation.
	In this example, and throughout the following lessons, keywords will be capitalized. <code>SELECT</code> and <code>FROM</code> are both keywords.
	They will appear in every query you ever write. The asterisk character and <em>schools</em> are
	both specific to this example.
</p>

<ul>
	<li><code>SELECT</code> is like saying <em>please find for me...</em></li>
	<li>The asterisk is a <em>wildcard</em> character that means <em>everything available</em>.</li>
</ul>

<p>
	So, the statement <code>SELECT *</code> is like saying <em>please find for me everything available</em>
</p>

<ul>
	<li>The keyword <code>FROM</code> tells the database in what table(s) to look</li>
	<li><em>schools</em> is the name of the table we want it to look in</li>
</ul>

<p>
	So, in plain English, this query might read <em>please find everything available from the schools table</em>.
</p>

<p>
	Let's try it out!
</p>
" )

Lesson.create( title: 'Introduction To Conditional Statements', objective: 'Filter your results with a single condition.', body: "
<p>
	As you saw, a little bit of SQL can give you a <em>lot</em> of results.  The first query you wrote returned
	over seven thousand different schools!  If you're thinking <em>that doesn't seem very helpful...</em> you are
	absolutely correct.
</p>

<p>
	SQL's most powerful feature is its ability to filter results.  It's also the most fun!  Thinking creatively about
	how to write the correct SQL statement to get the results you are interested in is like solving a puzzle.  Let's look
	at an example:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE city = 'University Park'</textarea>

<p>
	This query would return exactly one row:
</p>

<table class='table table-bordered table-responsive'>
	<tbody>
		<tr>
			<td>3636</td>
			<td>Pennsylvania State University-Main Campus</td>
			<td>University Park</td>
			<td>PA</td>
			<td>16802-1589</td>
			<td>Dr. Eric J. Barron</td>
			<td>1</td>
		</tr>
	</tbody>
</table>

<p>
	The first two lines of this query are exactly the same as the first query we wrote.  The SELECT and FROM keywords
	are still present.  As previously noted, they will appear in every query you ever write.   It is the third line
	that made such a difference and caused the database to return one row instead of seven thousand.
	Let's inspect that line now.
</p>

<ul>
	<li><code>WHERE</code> is like saying <em>I am only interested in the rows that meet this condition</em></li>
	<li><em>city</em> is one of the columns in the schools table; it is an attribute of a school</li>
	<li><code>=</code> is a SQL operator; it compares the attribute on its left to the value on its right</li>
	<li><em>'University Park'</em> is a value that you have provided, in this case a city you are interested in</li>
</ul>

<p>
	Note the quotation marks around the value; these are required for text values only.
	Numerical values do not need quotation marks.
</p>

<p>
	In plain English, the entire query would read: <em>please give me all the attributes of any schools in which the city exactly matches 'University Park'</em>.
</p>

<aside>
	<h4>A Brief Aside Concerning Capitalization</h4>
	<p>
		Throughout these lessons, you will not need to worry about capitalization when typing your SQL.
		This means that <code>SELECT</code> will effectively be the same as <code>select</code>,
		which will effectively be the same as <code>SeLeCt</code>. In ScriptKitty the following
		two queries are interchangeable:
	</p>

	<textarea class='raw-sql'>select *
from schools
where city = 'university park'</textarea>

	<textarea class='raw-sql'>sElEcT *
fRoM sChOoLs
wHeRe cItY = 'uNiVeRsItY PaRk'</textarea>

	<p>
		It is worth noting that this does not <em>always</em> hold true \"in the real world.\"
		SQL itself is not a case-sensitive language, but sometimes the computer that interprets it <em>is</em>.
		This has nothing to do with the computer you are using right now, but rather the web-server
		that is running ScriptKitty and interpretting your SQL for you.
	</p>

	<p>
		While ScriptKitty will interpret your queries in a case-insensitive manner, it is good practice
		to pay attention to how tables and columns are capitalized and mimic this in the SQL you type.
	</p>
</aside>

<p>
	  Here's one more example:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE state = 'AK'</textarea>

<p>
	In plain English, the query would read: <em>please give me all the attributes of any schools in which the state exactly matches 'AK'</em>.  This query returns the following twelve rows:
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>63</td>
			<td>University of Alaska Anchorage</td>
			<td>Anchorage</td>
			<td>AK</td>
			<td>99508</td>
			<td>Fran Ulmer</td>
			<td>1</td>
		</tr>
		<tr>
			<td>64</td>
			<td>Alaska Bible College</td>
			<td>Glennallen</td>
			<td>AK</td>
			<td>99588</td>
			<td>Nicholas Ringger</td>
			<td>12</td>
		</tr>
		<tr>
			<td>65</td>
			<td>University of Alaska Fairbanks</td>
			<td>Fairbanks</td>
			<td>AK</td>
			<td>99775-7500</td>
			<td>Brian Rogers</td>
			<td>6</td>
		</tr>
		<tr>
			<td>66</td>
			<td>University of Alaska Southeast</td>
			<td>Juneau</td>
			<td>AK</td>
			<td>99801-8697</td>
			<td>John Pugh</td>
			<td>9</td>
		</tr>
		<tr>
			<td>67</td>
			<td>Alaska Pacific University</td>
			<td>Anchorage</td>
			<td>AK</td>
			<td>99508</td>
			<td>Don Bantz</td>
			<td>1</td>
		</tr>
		<tr>
			<td>68</td>
			<td>AVTEC-Alaska's Institute of Technology</td>
			<td>Seward</td>
			<td>AK</td>
			<td>99664-0889</td>
			<td>Fred Esposito</td>
			<td>12</td>
		</tr>
		<tr>
			<td>69</td>
			<td>Charter College-Anchorage</td>
			<td>Anchorage</td>
			<td>AK</td>
			<td>99508</td>
			<td>Terrance Harris</td>
			<td>1</td>
		</tr>
		<tr>
			<td>70</td>
			<td>Prince William Sound Community College</td>
			<td>Valdez</td>
			<td>AK</td>
			<td>99686-0097</td>
			<td>Douglas A. Desorcie</td>
			<td>12</td>
		</tr>
		<tr>
			<td>71</td>
			<td>Career Academy</td>
			<td>Anchorage</td>
			<td>AK</td>
			<td>99507-1033</td>
			<td>Jennifer Deitz</td>
			<td>1</td>
		</tr>
		<tr>
			<td>72</td>
			<td>University of Alaska System of Higher Education</td>
			<td>Fairbanks</td>
			<td>AK</td>
			<td>99775-5000</td>
			<td>Patrick Gamble</td>
			<td>6</td>
		</tr>
		<tr>
			<td>5762</td>
			<td>Ilisagvik College</td>
			<td>Barrow</td>
			<td>AK</td>
			<td>99723</td>
			<td>Beverly Patkotak Grinage</td>
			<td>10</td>
		</tr>
		<tr>
			<td>6095</td>
			<td>Alaska Christian College</td>
			<td>Soldotna</td>
			<td>AK</td>
			<td>99669</td>
			<td>Dr. Keith J. Hamilton</td>
			<td>10</td>
		</tr>
	</tbody>
</table>

<p>
	If you think you're ready, you can practice what you've learned in the next exercise.
</p>
" )

Lesson.create( title: '<em>Equals</em> is not the only operator', objective: 'Search through text using the <em>like</em> operator.', body: "
<p>
	In the <a href='./2/'>previous lesson</a>, we learned how to limit the results of our query by adding a condition.
	The <code>WHERE</code> keyword signifies that you want to limit your results by comparing some value to some table attribute
	using an operator.  We learned how to use the <code>=</code> operator to perform an exact match.
</p>

<p>
	It was pretty cool, and it can definitely be helpful in some situations, but because it looks
	for <em>exact</em> matches only, it is somewhat constraining. For example, this query
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE name = 'Yale'</textarea>

<p>
	would return no rows from this database.  While several schools <em>contain</em> the text 'Yale' in their name,
	none are <em>exactly</em> that.  There is one school with the name 'Yale University' but that is not an exact match for 'Yale'.
</p>

<p>
	  Is there a way to see if a field contains a bit of text?  There is!
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE name LIKE '%Yale%'</textarea>

<p>
	Most of this query is the same as the previous example.  There are two important differences, however.
	<ul>
		<li>the operator is <code>LIKE</code> instead of <code>=</code></li>
		<li>the text is now wrapped inside both quotation marks and <code>%</code> symbols</li>
	</ul>
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>cite</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>760</td>
			<td>Yale-New Haven Hospital Dietetic Internship</td>
			<td>New Haven</td>
			<td>CT</td>
			<td>06510</td>
			<td>Stephen Merz</td>
			<td>2</td>
		</tr>
		<tr>
			<td>761</td>
			<td>Yale University</td>
			<td>New Haven</td>
			<td>CT</td>
			<td>06520</td>
			<td>Richard C Levin</td>
			<td>2</td>
		</tr>
		<tr>
			<td>5102</td>
			<td>Royale College of Beauty</td>
			<td>Temecula</td>
			<td>CA</td>
			<td>92590</td>
			<td>Barbara Kruis</td>
			<td>10</td>
		</tr>
	</tbody>
</table>

<p>
	There are many different operators available in SQL that each perform a unique action.
	The <code>LIKE</code> operator checks an attribute to see if it contains some text you provide.
</p>

<p>
	The <code>%</code> symbols are a way of denoting that there is an unknown number of characters
	before and after your text.  It doesn't matter what they are.  What matters is whether the attribute
	contains the text between the two <code>%</code> symbols.  If it does, it will show up in your results.
</p>

<p>
	So, in plain English, the SQL query above would read:
</p>

<p>
	<em>
		please find all the attributes<br>
		of all the schools in the Schools table<br>
		in which the name of the school contains the text 'Yale'
	</em>
</p>

<p>
	If you think you're ready, you can practice what you've learned in the next exercise.
</p>
" )

Lesson.create( title: 'Compound Conditional Statements: Part 1', objective: 'Chain two conditions together with <em>OR</em>.', body: "
<p>
	We're starting to pick up some steam now!  We've learned how to search for exact matches using <code>=</code>
	and how to sift through text using <code>LIKE</code>.  Remember that those are both called operators.  There
	are a few more handy operators that we'll cover eventually, but we'll get to those later.  This lesson will introduce
	the idea of <em>compound conditions</em>.
</p>

<p>
	Suppose we wanted to look for schools where the chief's name was Kate.  ...Or maybe it was Cate?  Hmm.  I heard the name out loud,
	but I'm not sure how it was spelled (<em>Kate</em> or <em>Cate</em>).  I should probably query for both just to be thorough.
</p>

<p>
	One way to approach this would be to write two different queries and examine the results of each separately.
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE chief LIKE '%Kate%';

SELECT *
FROM schools
WHERE chief LIKE '%Cate%'</textarea>

<p>
	While this does work, it would be inconvenient to have two separate sets of results to look through.
</p>

<aside>
	<h4>A Brief Aside Concerning Semicolons</h4>
	<p>
		If you explore the Internet seeking other examples of SQL, you may see semicolons being used
		to terminate queries, much like a punctuation mark denoting the end of a sentence.  Generally speaking,
		this is optional, <strong>unless</strong> you are typing two queries back to back like above!
	</p>

	<p>
		In such situations, the semicolon does serve to separate the end of one query from the beginning of
		the next.  You will never need to write multiple queries simultaneously in these exercises, however.
		Because of this, you won't see semicolons mixed in with SQL code often in these lessons.
	</p>
</aside>


<p>
	Thankfully, we can combine those into a single query using <code>OR</code>:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE chief LIKE '%Kate%'
OR chief LIKE '%Cate%'</textarea>

<p>
	Using <code>OR</code> often broadens your result set.  If one condition is not true, perhaps the other one will be.
	Neat!  Let's check our results:
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
		</tr>
	</thead>

	<tbody>
		<tr>
			<td>266</td>
			<td>University of California-Davis</td>
			<td>Davis</td>
			<td>CA</td>
			<td>95616-8678</td>
			<td>Linda Katehi</td>
			<td>6</td>
		</tr>
		<tr>
			<td>1351</td>
			<td>Brown Mackie College-Michigan City</td>
			<td>Michigan City</td>
			<td>IN</td>
			<td>46360-7362</td>
			<td>Kate Osio</td>
			<td>10</td>
		</tr>
		<tr>
			<td>1486</td>
			<td>Cowley County Community College</td>
			<td>Arkansas City</td>
			<td>KS</td>
			<td>67005</td>
			<td>Patrick McAtee</td>
			<td>8</td>
		</tr>
		<tr>
			<td>3202</td>
			<td>Ohio Business College-Sheffield</td>
			<td>Sheffield Village</td>
			<td>OH</td>
			<td>44035-0701</td>
			<td>Rosanne Catella</td>
			<td>5</td>
		</tr>
		<tr>
			<td>4678</td>
			<td>Maricopa Skill Center</td>
			<td>Phoenix</td>
			<td>AZ</td>
			<td>85034-4101</td>
			<td>Sue Kater</td>
			<td>1</td>
		</tr>
		<tr>
			<td>6087</td>
			<td>Vatterott College-Cleveland</td>
			<td>Broadview Heights</td>
			<td>OH</td>
			<td>44147-3502</td>
			<td>Kate Spies</td>
			<td>4</td>
		</tr>
		<tr>
			<td>6309</td>
			<td>Kaplan University-Council Bluffs Campus</td>
			<td>Council Bluffs</td>
			<td>IA</td>
			<td>51503-5289</td>
			<td>Kate Packard</td>
			<td>3</td>
		</tr>
		<tr>
			<td>6823</td>
			<td>Brown Mackie College-Indianapolis</td>
			<td>Indianapolis</td>
			<td>IN</td>
			<td>46204</td>
			<td>Kate Osio</td>
			<td>1</td>
		</tr>
		<tr>
			<td>7037</td>
			<td>PC ProSchools</td>
			<td>Brookfield</td>
			<td>WI</td>
			<td>53005-0000</td>
			<td>Kate Pelchat</td>
			<td>4</td>
		</tr>
	</tbody>
</table>

<p>
	You are not limited to using <code>OR</code> once in a query.  In 'real world' queries,
	<code>OR</code> is commonly used to chain multiple conditions together, like this example:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE chief LIKE '%Kate%'
OR chief LIKE '%Cate%'
OR chief LIKE '%Cait%'
OR chief LIKE '%Catherine%'</textarea>

<p>
	That query returns an additional five rows because of the extra conditions.
	Only one of the four conditions needed to be true, increasing the likelihood that the
	chief's name would contain the text you supplied.
</p>

<p>
	You're doing great!  Give yourself a pat on the back.  When you feel ready, you can try the
	next exercise to practice these skills.
</p>
" )

Lesson.create( title: 'Compound Conditional Statements: Part 2', objective: 'Chain two conditions together with <em>AND</em>.', body: "
<p>
	In the <a href='./4'>previous lesson</a> we learned how to broaden the scope of our queries
	by using OR to chain conditions together.  In this lesson, we'll cover the opposite idea -- a way to narrow
	the scope of your queries and make them <em>more</em> specific.  We can do this using the <code>AND</code>
	keyword.
</p>

<p>
	Suppose we wanted to find some schools in the city of Harrisburg, Illinois.  If we wrote a query like this:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE city = 'Harrisburg'</textarea>

<p>
	...we would primarily get results from Harrisburg, Pennsylvania!  It looks like we need to be more specifc.
</p>

<p>
	In a situation like this, we could use an <code>AND</code> to chain more than one condition.  In this case,
	<em>both</em> conditions must be true for the row to be returned.  (This is a significant difference from using
	<code>OR</code>, where only one condition needed to be true.)  The query would look like this:
<p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE state = 'IL'
AND city = 'Harrisburg'</textarea>

<p>
	It would return a single row:
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
		</tr>
	</thead>

	<tbody>
		<tr>
			<td>1257</td>
			<td>Southeastern Illinois College</td>
			<td>Harrisburg</td>
			<td>IL</td>
			<td>62946</td>
			<td>Jonah Rice</td>
			<td>11</td>
		</tr>
	</tbody>
</table>

<p>
	 Note that this row meets both conditions.  The state exactly matches 'IL' and the city matches
	 the text 'Harrisburg'.
</p>

<p>
	Some people find it helpful to think of <code>AND</code> in terms of a Venn Diagram.
</p>

<p>
	<img src='/assets/logical-and.png'>
</p>

<p>
	<code>WHERE state = 'IL'</code> is a single condition that would return its own set of results.<br>
	<code>WHERE city = 'Harrisburg'</code> is also a single condition that would return its own set of results.
</p>

<p>
	By chaining them together with an <code>AND</code> we let the database know that we are only interested in
	the results that are common to both.
</p>
" )

Lesson.create( title: 'Does Not Equal', objective: 'Filter your results using the <em>does not equal</em> operator.', body: "
<p>
	Now that we've learned how to chain multiple conditions together using <code>AND</code> and <code>OR</code>,
	we can continue with operators.  This lesson will be short, but can be useful at times to limit results.  It
	will introduce the idea of <em>does not equal</em>.
</p>

<p>
	Let's say we live in the small town of Scranton, Pennsylvania where the most well-known school is the University
	of Scranton.  We're interested in staying local, but are also interested in seeing what other schools are available!
	In essence, we're asking <em>what schools are in Scranton that aren't the University of Scranton?</em>
</p>

<p>
	In SQL form, that question would look like:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE city = 'Scranton'
AND name &lt;&gt; 'University of Scranton'</textarea>

<p>
	The SQL operator for <em>does not equal</em> here is represented as <code>&lt;&gt;</code> and the query returns
	results like:
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
		</tr>
	</thead>

	<tbody>
		<tr>
			<td>3563</td>
			<td>Johnson College</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18508-1495</td>
			<td>Ann L. Pipinski, Ed.D.</td>
			<td>3</td>
		</tr>
		<tr>
			<td>3572</td>
			<td>Lackawanna College</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18509-3206</td>
			<td>Ray Angeli</td>
			<td>3</td>
		</tr>
		<tr>
			<td>3596</td>
			<td>Marywood University</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18509-1598</td>
			<td>Sister Anne Munley</td>
			<td>3</td>
		</tr>
		<tr>
			<td>3735</td>
			<td>Yeshivath Beth Moshe</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18505</td>
			<td>Avraham Pressman</td>
			<td>3</td>
		</tr>
		<tr>
			<td>4667</td>
			<td>Career Technology Center of Lackawanna County</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18508</td>
			<td>Vincent P Nallo</td>
			<td>10</td>
		</tr>
		<tr>
			<td>5149</td>
			<td>Fortis Institute-Scranton</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18509-2903</td>
			<td>Duncan Anderson</td>
			<td>3</td>
		</tr>
		<tr>
			<td>7132</td>
			<td>The Commonwealth Medical College</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18510</td>
			<td>Robert M D'Alessandri M.D</td>
			<td>3</td>
		</tr>
		<tr>
			<td>7408</td>
			<td>Commonwealth Medical College (The)</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18503</td>
			<td>Robert D'Alessandri, MD</td>
			<td>3</td>
		</tr>
	</tbody>
</table>

<p>
	In plain English, it might be more natural to read the query as <em>find all information about schools where
	the city is 'Scranton' <strong>but</strong> the name is not 'University of Scranton'</em>
</p>

<p>
	Keep in mind that there is no <em>but</em> keyword in SQL; there is only <code>AND</code> and <code>OR</code>.
<p>

<p>
	It is also worth noting that <em>does not equal</em> is usually written as <code>&lt;&gt;</code>
	but it is sometimes written as <code>!=</code>
</p>

This:
<textarea class='raw-sql'>SELECT *
FROM schools
WHERE city = 'Scranton'
AND name != 'University of Scranton'</textarea>

<p>
	would return the same results as:
</p>
<textarea class='raw-sql'>SELECT *
FROM schools
WHERE city = 'Scranton'
AND name &lt;&gt; 'University of Scranton'</textarea>

<p>
	They are two ways of saying the same thing.  Both are equally valid, but <code>&lt;&gt;</code>
	is more commonly seen and used.
</p>

<p>
	That's really all there is to it; it's not too tough!  If you feel ready, you can try the next exercise.
</p>
" )

Lesson.create( title: 'Being more specific than <em>SELECT *</em>', objective: 'Limit results to specific columns from the database table.', body: "
<p>
	In all the exercises up to this point, we have always retrieved full rows from the database.  The <em>Schools</em>
	table has seven columns, and each of our queries has returned all seven columns per row.  For example, this query
	from <a href='./2'>Lesson 2</a>:
</p>

<textarea class='raw-sql'>SELECT *
FROM schools
WHERE city = 'University Park'</textarea>

<p>
	returned a single row with all seven columns intact.
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>id</th>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
			<th>chief</th>
			<th>locale_id</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>3636</td>
			<td>Pennsylvania State University-Main Campus</td>
			<td>University Park</td>
			<td>PA</td>
			<td>16802-1589</td>
			<td>Dr. Eric J. Barron</td>
			<td>3</td>
		</tr>
	</tbody>
</table>

<p>
	This can be useful when we want to learn as much as possible about what we're querying for.
	There are times, however, when we just need one thing, or when retreiving all the columns
	would be overwhelming.  (It is not uncommon for 'real world' database tables to have thirty or forty
	columns!)
</p>

<p>
	So, there are situations when <code>SELECT *</code> is too broad.  In such cases, we can specify
	exactly which columns we are interested in retrieving.  Let's take a look at this query:
</p>

<textarea class='raw-sql'>SELECT chief
FROM schools
WHERE city = 'University Park'</textarea>

<p>
	This would return a result set like:
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>chief</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Dr. Eric J. Barron</td>
		</tr>
	</tbody>
</table>

<p>
	Notice that instead of the usual <code>SELECT *</code>, we've specified a column.  <code>SELECT chief</code>
</p>

<p>
	We can retrieve two or more columns by separating them with commas.  This query:
</p>

<textarea class='raw-sql'>SELECT name, city, state, zip
FROM schools
WHERE zip like '%18509%'</textarea>

<p>
	returns three rows across four columns.
</p>

<table class='table table-bordered table-responsive'>
	<thead class=\"thead-dark\">
		<tr>
			<th>name</th>
			<th>city</th>
			<th>state</th>
			<th>zip</th>
		</tr>
	</thead>

	<tbody>
		<tr>
			<td>Lackawanna College</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18509-3206</td>
		</tr>
		<tr>
			<td>Marywood University</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18509-1598</td>
		</tr>
		<tr>
			<td>Fortis Institute-Scranton</td>
			<td>Scranton</td>
			<td>PA</td>
			<td>18509-2903</td>
		</tr>
	</tbody>
</table>

<p>
	You're doing great and you're nearly done!  After you complete the exercises for this lesson,
	there is only one lesson left!
</p>
" )

Lesson.create( title: 'Using More Than One Table', objective: 'Write a complex query that pulls data from more than one table.', body: "
<p>
	While there are three different tables we can potentially query (<em>Schools</em>, <em>Locales</em>,
	and <em>Websites</em>), all of our queries so far have only retrieved data from a single table.  It's time
	to change that. In this lesson we're going to write queries that retrieve data from <em>more than one table</em>.
</p>

<p>
	If you haven't explored the three tables yet, you should take a few minutes to do that now, using the
	<em>Tables</em> dropdown menu at the top of the page.  This lesson will be waiting for you when you get back!
</p>

<hr>

<p>
	We'll start this lesson with a new scenario:
</p>

<p>
	<em>Find the name and state of the schools<br>
	and the name of the locale that each school is located in<br>
	for all schools where the city is named 'Orange'<br>
	and the state is not 'CA'.</em>
</p>

<p>
	The resulting query that correctly solves this question is a bit unlike anything we've
	encountered so far.
</p>

<textarea class='raw-sql'>SELECT schools.name, schools.state, locales.name
FROM schools
JOIN locales ON schools.locale_id = locales.id
WHERE schools.city = 'Orange'
AND schools.state &lt;&gt; 'CA'</textarea>

<p>
	Just like we did in Lesson 1, let's examine this query line by line.
</p>

<p>
	You probably noticed right away that the columns in the first line have their corresponding tables
	prepended to them.  Why is this suddenly necessary?  Keep in mind that we are retrieving data from
	two tables, <em>Schools</em> and <em>Locales</em>, and that both tables have a <em>name</em> column.
	By prepending the table like <em>schools.name</em> and <em>locales.name</em>
	we are explicitly informing SQL which <em>name</em> we want to be retrieved.
</p>

<p>
	The second line is familiar, (we are retrieving data <code>FROM schools</code>),
	but perhaps it is also confusing.  What about <em>locales</em>?  Shouldn't we also retrieve
	data <code>FROM locales</code>?
</p>

<p>
	Well, we do!  With each additional table we want to query, we'll need an additional line of SQL
	explicitly <code>JOIN</code>ing that table to the original in a meaningful way.  In this example,
	the third line of the query serves to <code>JOIN</code> the second table to the first.
</p>

<p>
	A <code>JOIN</code> statement will always be followed by a meaningful <code>ON</code> statement,
	which might look similar to the simple <code>WHERE</code> statements we learned in <a href='./2'>Lesson 2</a>.
	<code>ON</code> is different, however, in that it must utilize the <code>=</code> operator to link
	two related columns from two different tables which are typically numerical IDs. Here, we are linking <em>locales.id</em> and <em>schools.locale_id</em>.
</p>

<aside>
	<h4>A Brief Aside Concerning Underscores</h4>
	<p>
		The underscore in <em>locale<strong>_</strong>id</em> is a programming convention.
		SQL, like virutally every programming language, uses spaces to signify the end of one thing
		and the start of another.  If we were to write a query like:
	</p>

	<textarea class='raw-sql'>SELECT name, city, locale id
FROM schools
WHERE city = 'university park'</textarea>

	<p>
		SQL would want to interpret <em>locale</em> and <em>id</em> as two separate columns,
		and it would return a syntax error because there wasn't a comma between them. So,
		while <em>locale id</em> is two words in plain English, we want to think of it as one unit
		for the sake of SQL.
	</p>
	<p>
		The two most common solutions to this problem are to simply remove
		whitespace ( <em>localeID</em> ) or to replace whitespace with underscores ( <em>locale_id</em> ).
		These lessons make use of the underscore convention.
	</p>
</aside>

<p>
	In ScriptKitty, and in most real-world scenarios, the database tables will be properly set up by an
	experienced database administrator to allow easy <code>JOIN</code>ing through thoughtfully named
	columns.  While relational database design is a worthy and engaging topic of its own, it is outside
	the scope of these lessons.  There are additional educational resources listed on the <a href='../about'>About</a>
	page if you are still curious later.
</p>

<p>
	Finally, the query has two conditions that are thankfully straightforward.  We've seen these
	concepts before, in <a href='./2'>Lesson 2</a> and <a href='./6'>Lesson 6</a>, respectively.
</p>


<p>
	The query will return exactly one row:
</p>

<table class='responsive' width='100%'>
	<thead class=\"thead-dark\">
		<tr>
			<th>name</th>
			<th>state</th>
			<th>name</th>
		</tr>
	</thead>

	<tbody>
		<tr>
			<td>Lamar State College-Orange</td>
			<td>TX</td>
			<td>Town, distant</td>
		</tr>
	</tbody>
</table>

<p>
	This lesson covered a lot of ground, and the concepts were really quite tricky.
	If you feel you need to read it over a few times, don't worry.  You can try out
	the last few exercises to test your skills whenever you're ready.
</p>
")