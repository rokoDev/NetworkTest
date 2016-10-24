//
//  SomeClass_test.cpp
//  NetTest
//
//  Created by roko on 7/22/16.
//  Copyright © 2016 roko. All rights reserved.
//

#define BOOST_TEST_DYN_LINK
#include <boost/test/unit_test.hpp>

#include "config.h"
#include "Rectangle.h"
#include "SomeClass_test.hpp"

BOOST_AUTO_TEST_CASE(int_test)
{
    int i = 2;
    BOOST_TEST(i);
    BOOST_TEST(i == 2);

}

BOOST_AUTO_TEST_CASE(area_test)
{
    Rectangle rect;
    rect.set_values(2, 3);
    BOOST_TEST(60 == rect.area());
}

BOOST_AUTO_TEST_CASE(config_test)
{
    auto major = SimpleNet::Version::Major;
    BOOST_TEST(0 == major);
}
