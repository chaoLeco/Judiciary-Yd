//getNewsId();
function getNewsId(newsid){
//    alert(newsid);
//	var str = location.search;
//	var newsid = str.split("?")[1].split("=")[1];
	getNewsDetail(newsid);
    
}


function getNewsDetail(newsID) {
	$.ajax({
		type: "get",
		url: serverUrl + "/index.php/Home/News/getNewsDetail?newid=" + newsID,
		success: function(m) {
			var obj = JSON.parse(m);
			if(obj.flag == 1) {
					document.getElementById("newsTitle").innerHTML = obj.data.news_title;
					document.getElementById("newsContent").innerHTML = obj.data.news_content;
					document.getElementById("newsTime").innerHTML = obj.data.news_time;
			} else {
				console.log(obj.message);
			}
		},
		error: function() {
			console.log("error")
		}
	});
}
