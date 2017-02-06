var rongSentMessage = (function() {
	//本地消息统一经过的入口
	var messgaeLocalSend = function(cfg,type){
		var sentTime = +new Date()
			var leng = document.querySelectorAll('#chatRoom .fix').length;
			var showTime;
			if(leng==0){
				showTime = 'db';
			}
			else{
				var difftime = sentTime - document.querySelectorAll('#chatRoom .fix')[leng-1].getAttribute('data-time');
				showTime = difftime >= 60000?'db':'dn';
			}
			var cfg = mui.extend(cfg,{showTime:showTime});
			switch(type) {
				case 'text':
					Chat.chatroom(cfg);
					break;
				case 'image':
					Chat.img(cfg);
					break;
				case 'audio':
					Chat.audio(cfg);
					break;
				default:
					break;
			}
	}
	//本地文本消息
	var text = function(text, ConversationType, targetId, userInfo) {
		var argus = {
			conversationType:ConversationType,
			targetId:targetId,
			content:text,
			pushContent:userInfo
		};
		plus.im.sendMessage(
			argus,
			function(result){
				if(!result.result){
					messgaeLocalSend({
						self: 'yes',
						userinfo: userInfo,
						msg:text,
						time:+new Date(),
						callback:function(boundingBox){
							document.getElementById('slc_mg').scrollTop = document.getElementById('slc_mg').scrollHeight;
							
						}
					},'text');
				}
			}
			,
			function( result ) {}
		);
	};
	//本地图片消息
	var img = function(ConversationType,targetId,token,path,userinfo) {
		var argus = {
			conversationType:ConversationType,
			targetId:targetId,
			token:token,
			path:mui.os.android ? path : plus.io.convertLocalFileSystemURL(path),
			pushContent:{},
			pushData:{}
		};
		plus.im.sendImageMessage(
			argus,
			function(result){
				if(!result.result){
					if(!result.result){
						messgaeLocalSend({
							thumBnail: mui.os.android ? path : plus.io.convertLocalFileSystemURL(path),
							largeUrl: mui.os.android ? path : plus.io.convertLocalFileSystemURL(path),
							self: 'yes',
							userinfo: userinfo,
							time:+new Date(),
							callback:function(){
								document.getElementById('slc_mg').scrollTop = document.getElementById('slc_mg').scrollHeight;
							}
						},'image');
					}
				};
			}
			,
			function( result ) {}
			,
			function(result) {}
			
		);
	};
	//本地本地语音消息
	var Audio = function(base64, ConversationType, targetId,duration, userInfo,absUrl) {
		var Argus = {
			conversationType:ConversationType,
			targetId:targetId,
			duration:duration,
			path:mui.os.android ? absUrl : plus.io.convertLocalFileSystemURL(absUrl),
			pushContent:userInfo,
			pushData:{}
		};
		plus.im.sendVoiceMessage(Argus,
			function(result){
				if(!result.result){
					messgaeLocalSend({
						data: base64,
						self: 'yes',
						duration:duration,
						userinfo: userInfo,
						absUrl:absUrl,
						time:+new Date(),
						callback:function(){
							document.getElementById('slc_mg').scrollTop = document.getElementById('slc_mg').scrollHeight;
						}
					},'audio');
				}
			}
			,
			function(result){
				
			}
		)
	};
	
	
	//历史消息，接收消息的统一入口
	var receiveMessage = function(result,arrayData,insertBefore,callback){
		var userinfo;
		var showTime;
		var difftime;
		
		var thisChatMessage = result;
		if(insertBefore){
			thisChatMessage.sort(function(a,b){
				return   a.messageId - b.messageId
			})	
		}
		var leng = result.length;
		for(var i = result.length -1; i>=0; i--){
			for (j in arrayData){
				if(arrayData[j].uuid == thisChatMessage[i].senderUserId){
					userinfo = arrayData[j];
				}
			}
			plus.im.setMessageReceivedStatus({messageId:thisChatMessage[i].messageId, receivedStatus:Number(thisChatMessage[i].receivedStatus.flag)+1});
			//只有一条历史记录，死活都要加上时间,
			if(i==leng-1){
				var pageUILeng = document.querySelectorAll('#chatRoom .fix').length;
				if(pageUILeng==0){
					showTime = 'db';
				}
				else{
					var difftime = thisChatMessage[i].receivedTime - document.querySelectorAll('#chatRoom .fix')[pageUILeng-1].getAttribute('data-time');
					showTime = difftime >= 60000?'db':'dn';
				}
			}
			else{
				if(i==0){
					
				}else{
					difftime = thisChatMessage[i].receivedTime - thisChatMessage[i-1].receivedTime;	
				}
				showTime = Math.abs(difftime) >= 60000 ?'db':'dn';
			}
			switch(thisChatMessage[i].objectName) {
				case MessageType.TextMessage:
					Chat.chatroom({
					self:thisChatMessage[i].senderUserId==localStorage.getItem('uuid') ? 'yes':'no',
					msg:thisChatMessage[i].content.content,
					userinfo:{
						id: userinfo.uuid,
						name: userinfo.nicknm,
						portraitUri: userinfo.avatarUrl || rongYun.defaultsAvatar
					},
					time:thisChatMessage[i].sentTime,
					showTime:showTime,
					insertBefore:insertBefore
				});
				break;
				case MessageType.VoiceMessage:
					Chat.audio({
						self:thisChatMessage[i].senderUserId==localStorage.getItem('uuid') ? 'yes':'no',	
						data: (thisChatMessage[i].content.wavAudioData==null||thisChatMessage[i].content.wavAudioData=='undefined') ? thisChatMessage[i].content.voiceUri : thisChatMessage[i].content.wavAudioData,
						duration: thisChatMessage[i].content.duration,
						userinfo:{
							id: userinfo.uuid,
							name: userinfo.nicknm,
							portraitUri: userinfo.avatarUrl || rongYun.defaultsAvatar
						},  
						time:thisChatMessage[i].sentTime,
						showTime:showTime,
						insertBefore:insertBefore
					})
					break;
				case MessageType.ImageMessage:
					Chat.img({
						thumBnail: (thisChatMessage[i].content.thumbnailBase64String==null||thisChatMessage[i].content.thumbnailBase64String=='undefined') ?thisChatMessage[i].content.thumbUri:('data:image/png;base64,'+thisChatMessage[i].content.thumbnailBase64String),
						self:thisChatMessage[i].senderUserId==localStorage.getItem('uuid') ? 'yes':'no',
						userinfo:{
							id: userinfo.uuid,
							name: userinfo.nicknm,
							portraitUri: userinfo.avatarUrl || rongYun.defaultsAvatar
						},
						largeUrl:(thisChatMessage[i].content.imageUrl==null||thisChatMessage[i].content.imageUrl=='undefined') ? thisChatMessage[i].content.imageUri : thisChatMessage[i].content.imageUrl,
						time:thisChatMessage[i].sentTime,
						showTime:showTime,
						insertBefore:insertBefore
					});
					break;
				case MessageType.RichContentMessage:
					Chat.pusher({
						title: thisChatMessage[i].content.title,
						msg: thisChatMessage[i].content.digest,
						bnUrl:thisChatMessage[i].content.imageURL,
						linkUrl: thisChatMessage[i].content.url,
						msgType: JSON.parse(thisChatMessage[i].content.extra).msgType,
						msgId: JSON.parse(thisChatMessage[i].content.extra).msgId,
						itemPk: JSON.parse(thisChatMessage[i].content.extra).itemPk,
						time: thisChatMessage[i].sentTime,
						insertBefore:insertBefore
					});
					break;
				default:
					break;
				}
			
		}
		callback();
	}
	//语音播放时，包括原生的，以及本地其他音频都应该停止，让钱音频播放！
	var audioControl = function(audioArray){
		plus.im.stopPlayVoice();
		for(var i=0;i<audioArray.length; i++){
			audioArray[i].play(function(){},function(){});
			audioArray[i].stop();	
			audioArray.splice(i,1);
		}
		return  audioArray
	}
	
	return {
		text: text,
		img: img,
		Audio: Audio,
		receiveMessage:receiveMessage,
		audioControl:audioControl
	}
})();
