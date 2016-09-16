#pragma once

#include <string>

namespace SimpleNet {
	struct Version {
		static const int Major;
		static const int Minor;
		static const int Patch;
		static const int Tweak;
		static const std::string String;
		static const std::string GIT_SHA1;
	};
}