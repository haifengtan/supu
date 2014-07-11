
#import "SPBaseAction.h"

@protocol SPAddToShoppingCartActionDelegate
-(NSDictionary *)onRequestAddToShoppingCart;
-(void)onResponseAddToShoppingCartSuccess;
-(void)onResponseAddToShoppingCartFail;

@end

@interface SPAddToShoppingCartAction : SPBaseAction{
    ASIHTTPRequest *m_request_shopCart;
    id<SPAddToShoppingCartActionDelegate> m_delegate_shopCart;
}
@property(nonatomic,assign)id<SPAddToShoppingCartActionDelegate> m_delegate_shopCart;

/**
 *	@brief	发出请求
 *	
 *	发出添加到购物车请求
 */
-(void)requestAddToShoppingCartData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddToShoppingCartDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddToShoppingCartDataFailResponse:(ASIHTTPRequest*)request;
@end
