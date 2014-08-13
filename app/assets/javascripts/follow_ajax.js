$(function (){
	$('aside.user[user_id], li.user[user_id]').find('.btn').click(function(event){
		var $this = $(this);
		var userId = $this.parents().filter('.user').attr('user_id');
		if ($(this).hasClass('btn-primary')){
			$.ajax({
				url: '/users/'+userId+'/follow',
				type: 'POST',
				success: function(data, status){
					$this.html('Unfollow').removeClass('btn-primary');
					$this.html('Unfollow').addClass('btn-info');
				},
				error: function( jqXHR, textStatus, errorThrown ){
					alert(jqXHR+","+textStatus+","+errorThrown);
				},

			});
		}
		else{
			$.ajax({
				url: '/users/'+userId+'/unfollow',
				type: 'DELETE',
				success: function(data, status){
					$this.html('Unfollow').removeClass('btn-info');
					$this.html('Follow').addClass('btn-primary');
				}
			});
		}
		event.preventDefault();
	});
});

