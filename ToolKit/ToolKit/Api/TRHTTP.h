//
//  TRHTTP.h
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/23.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#ifndef TRHTTP_h
#define TRHTTP_h
// Online UAT local
#define UAT

#ifdef Online
#define BaseUrl @"http://192.168.31.111:8101"
#define CdnUrl @""
#endif

#ifdef UAT
#define BaseUrl @"http://120.25.226.186:32812"
#define CdnUrl @""
#endif

#ifdef Local
#define BaseUrl @"http://192.168.31.111:8101"
#define CdnUrl @""
#endif


#endif /* TRHTTP_h */

